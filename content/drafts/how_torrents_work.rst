#################
How Torrents Work
#################


# Notes from spec bep_0003
Torrent distribution works with:
webserver, metainfo file, bittorrent tracker, original downloader, end
user web browsers, end user downloaders

there are multiple end users for a single file.

To start serving, host does:
- starts running a tracker, runs ordinary web server, associate .torrent
  with mimetype application/x-bittorrent, generate metainfo file using
  the file and url of tracker, put metainfo on the server, link the
  metainfo from some other web page, start a downloader that has the
  complete file (the origin).

To start downloading, user does:
install bittorrent, surf web, click .torrent file link, select where to
save the file, wait for download to complete, tell downloader to exit
(it keeps uploading until this happens).

metainfo file is bencoded.

MetaInfo File:
bencoded dictionaries with the keys:

- annouce: url of tracker
- info: has the keys:
    - name: suggested name to save the file (if single file, name is
      name of file, for multiple files, name is name of directory see
      key length below)
    - piece length: no of bytes each piece the file is split into. File
      is split into fixed size pieces all the same length except the
      last one which may be truncated.
    - pieces: string whose length is multiple of 20. It's subdivided
      into strings of length 20, each of which is the SHA1 has of the
      piece at the corresponding index. SHA1 produces 20 byte hash
      output from any string (https://en.wikipedia.org/wiki/SHA-1)
    - key length or key files.
      key length means its a single file, otherwise set of files
      if single file, length maps to length of file in bytes
      for multi file, its treated as single file by concatenatin the
      files in the order they appear in files list. Files list is the
      value files map to and is a list of dics containing:
        - length: len of file in bytes
        - path: list of utf-8 strings corresponding to subdirectory
          names, last which is actual file name

Trackers:         
GET requests have:
    - info_hash: 20 byte sha1 has on bencoded form of info value from
      metainfo file.
    - peer_id: string of len 20 which downloader uses as its id. Each
      downloader generates its own id at random at start of new
      download.
    - ip: optional parameeter gicing the IP which peer is at. Generally
      used for the origin if it's on the same machine as the tracker.
    - port: port the peer is listening on.
    - uploaded: total amount uploaded so far
    - downloaded: total amount downloaded so far.
    - left: no of bytes peer still has to download. Cant be computed
      from downloaded and file length since there's a change some
      downloaded data failed an integrity check and had to be
      re-downloaded. There's also a change it might be a resume (what
      does this mean?)
    - event: optional key mapping to started, completed or stopped (or
      empty which is same as not being present). Announcement using
      started is sent when a download first begins, and one using
      completed is sent when download is complete. Downloaderse sent an
      announcement using stopped when they cease downloading.

Tracker responses:
    - can have key error that maps to human readable string explaining
      why query faileed.
    - if no error it has two keys: interval (maps to no of seeconds th
      downloader should wait between regular rerequests), peers (map to
      list of dictionaries corresponding to peers, each of which
      contains keys peer id, ip, port)
      more commonly a compact representation of peer list is returned.

Peer protocol:
- operates over TCP or uTP
  peer connections are symmetrical, messages  and data can flow in
  either direction.
  refers to pieces of file by index, starting zero. When peer finishes
  downloading a piece, it checks that the hash matches and announces
  that it has that piece to all its peers.
  Connections contain two bits of state: choked or not, interested or
  not. Choking notifies that no data will be sent until unchoking
  happens.
  Data transfer happens when one side is interested and the other side
  is not choking.
  Connections start out choked and not interested.
  Downloaders should keep several pieece requests queued up at once in
  order to get good TCP performance (pipelining). On other side,
  requests that cant be written out to the TCP buffer immediately should
  be queued up in memory rather that in applicaltion level network
  buffer, so that they can all be thrown out hen a choke happens.
  Peer protocol starts with handshake followed by never ending stream of
  length prefixed messages.
  After fixed header, there are 8 reserved bytes which are zero in
  current implementation, then 20 byte sha1 hash on info value (which
  should be the same as what was announced as info_hash to tracker).
  Next is the 20byte peeer id which is reported in tracker requests and
  contained in peer lists in tracker responses.
  Next comes alternating stream of length prefixes and messages.
  Messages of length zero are keep lalives, send once every two minutes.

  The peers and downloaders communicate with each other using non keep
  alive messages. These include flags for choke, unchoke, interested,
  not interested, have, bitfield, request, piece, cancel


TODO: research wireshark and run a sample download of a torrent to see
what happens

wireshark references: https://gitlab.com/wireshark/wireshark/-/wikis/BitTorrent




Bittorrent works with:


The Torrent File:

 {
     'announce': 'http://bttracker.debian.org:6969/announce',
     'info':
     {
         'length': 678301696,
         'name': 'debian-503-amd64-CD-1.iso',
         'piece length': 262144,
         'pieces': <binary SHA1 hashes>
     }
 }

https://en.wikipedia.org/wiki/Torrent_file
http://www.bittorrent.org/beps/bep_0003.html


