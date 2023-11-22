#########################
Future Proof Architecture
#########################


= Future Proofing Architecture =
Ref: https://www.reddit.com/r/ExperiencedDevs/comments/tcfzba/how_to_study_future_proofing_architecture/

Systems are designed to scale, which means:

- they're broken into pieces where each can scale independently e.g.
  horizontally via replication.
- data taht doesn't need scaling has a single source of truth. Data that does
  has some way to amortize access across many machines. This means a good
  understanding of:
    - distrubuted data stores
    - databases: distributed vs non-distrubuted, sql/schema/nosql dbs, object
      stores.
    - graph db
    - key values stores
    - distributed caches and proxiers
    - read "Designing Data-Intensive Applications" and get all useful theoretic
      tools like CAP theorem, replication, sharding, partitioning, locality,
      transactions, compression, caching, proxying.
- Data appears to be consistent within the system
- Client code is written once and scaling is automatic.
- Network traffic is amortized i.e. traffic spikes are minimized
- Monitor and alert on system bottlenecks.
- Every piece handles single host failure and network failures.
- Hosts/Data centers recover their state and return to normal ops after failure.
- Administration isn't cumbersome
- Parts of system can be upgraded independently.
- There's a way to back up the system.
- System preserves some aspect of state so that partial failurs can be recovered
  rather than restarted. Downtime for system is 'extremely low'.
- If production servers disappeared right now, how quickly could I get
  everything back up and running? The faster the better the architecture. The
  best systems have some failover capability (can be with reduced compute
  capacity). Beyond this, you'll do a combination of bringing up new servers or
  ramping up the failover clusters depending on how traige of original failure
  is progressing.
- Cohesion over coupling i.e. write code that works well together but doesn't
  necessarily rely on each other.


Notes:
https://www.youtube.com/watch?v=Y6Ev8GIlbxc&t=435s

What's a distributed system? Collection of independent users that appear to its
users as one computer e.g. amazon.com, cassandra cluster, kafka cluster.

They have 3 characteristics:

- computers operate concurrently
- the computers fail independently
- the computers don't share a global clock (e.g. collection of processors with
  clocks synchronized aren't distributed).

Topics: Storage, Computation, Messaging

Distributed Storage:

- Single Master storage: db only on one server.
- most web services have more reads than writes. In relation dbases reads are
  less expensive than writes.
- How do we scale reads? We do read-replication (propagate writes to master to
  the read servers). This breaks consistency. This is now an eventually
  consistent dbase.
- We can now scale the reads as much as we want but the writes end up becoming a
  bottleneck. To solve this we do sharding e.g. break up dbase based on key like
  usernames, like A-F in db1, F-N in db2, etc. and each of this has its
  followers. With this, we now break our data model, we can't join across
  shards.
- Suppose the dbase comes under pressure, latency is going up, higher
  transactions volume and reads aren't performing properly: most people will
  choose to add an index. If we already have all the indexing we can, we can
  realize that because of all this relational models, we have joins, so we take
  this away by denormalizing. Also, as write traffic increased, pressure on
  indexes increase.
- Consistent hashing: how do you build a dbase from the ground up to be
  distributed. Cassandra won't give us a lot of features and there are a lot of
  limitations.






TO read more:
https://tolerablecoder.blogspot.com/2019/06/getting-started-with-distributed-systems.html
https://tolerablecoder.blogspot.com/2019/06/a-list-of-corporate-engineering-blogs.html

https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/



