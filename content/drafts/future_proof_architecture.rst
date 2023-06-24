#########################
Future Proof Architecture
#########################


= Future Proofing Architecture =
Ref: https://www.reddit.com/r/ExperiencedDevs/comments/tcfzba/how_to_study_future_proofing_architecture/

System designed to scale. It can mean:

- every piece can scale in some way (horizontally via replication, etc)
- data that doesn't need to scale can have a single source of truth. Data that
  needs to scale has some way to amortize access across many machines.

    - At the fuzziest level, you can break down into the following categories:
        - Distributed Data Store
        - Databases:
            - Distributed vs. "Non Distributed"
            - SQL/Schema/NoSQL Databases
            - Object Store
        - Graph DB
        - Key Value Store
        - Distributed Cache and Proxies

     And in "Designing Data-Intensive Applications" and similar books, you can
     find all the usual theoretical tools and techniques (CAP theorem,
     replication, sharding, partitioning, locality, transactions, compression,
     caching, proxying, etc.).
     The key thing to notice is that you'll likely have at least a couple of the
     above systems and use each one for its designed purpose. Beyond that, it
     starts getting into the specific scenarios for data usage to determine where
     the bottlenecks are or where to optimize.
- Data appears to be consistent within the system
- Client code written once, and scaling part is automatic
- Network traffic is amortized, or traffic spikes are minimized.
- System bottlenecks are properly monitored and the right alerts are in place.
- Every piece can handle single host failure as well as network failure.
- After failure, hosts or data centers can easily recover their state and return
  to normal operation.
- Administration of such a system isn't cumbersome in any way.
- Any part of the system can be upgraded while the entire system is running.
- There's a way to back up the system.
- The system can preserve some aspect of state so that partial failures can be
  recovered rather than restarted.
  The downtime of the system is 'extremely low' 
- Often the question you also have to ask is "if my production servers
  disappeared right now, how quickly could I get everything back up and
  running". The faster your answer, the better your architecture. If the answer
  is never, you don't have a functional system architecture. 

    - The best systems have some sort of failover capability, with and without
      reduced compute capacity. Beyond that, you're likely doing a combination
      of bringing up new servers or ramping up the failover datacenter/cluster,
      depending on how debugging is going on the original failure.
- A mantra I think about often is "cohesion over coupling" and trying to write
  code that works well together, but doesn't necessarily rely on each other.


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



