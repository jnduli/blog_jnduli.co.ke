########################
Genetic Algorithm Basics
########################

:date: 2018-01-24 19:00
:tags: machine-learning
:category: Computer
:slug: genetic-algorithm-basic
:author: John Nduli
:status: draft

The genetic algorithm is a pretty awesome algorithm. Its used to
to optimize various situations and I've read about its use in many
papers. So to better understand it, I decided to implement one on
my own from scratch. For this, I used this tutorial for the
basics: `tutorial
<https://towardsdatascience.com/introduction-to-genetic-algorithms-including-example-code-e396e98d8bf3>`_

Basically the GA is an iterative process that works in the
following way:

.. code-block:: 

    Initialize the population
    set terminal condition and maximum generations for use
    Loop until terminal condition is met or max generations have been had:
        select the best from the population
        perform crossover amongst the best
        randomly do mutations

    present final solution gotten

For the basic implementation, I decided to create one where an
individual has 10 genes, which are either 0 or 1. The fittest
individual is one who has all genes as 1. The python
implementation for this is:

.. code-block:: python

    import random

    def generate_initial_population(size = 10):
        return [individual() for i in range(size)]

    class individual:
        def __init__(self, genes = None):
            if genes :
                self.genes = genes
            else:
                self.genes = [random.randint(0, 2)%2 for i in range(10)]

        def fitness(self):
            return sum(self.genes)

        def get_gene(self, index):
            return self.genes[index]

        def switch(self, index, value):
            self.genes[index] = value

        def __str__(self):
            return 'Individual' + str(self.genes)

        def __repr__(self):
            return 'Individual' + str(self.genes)

To note is that to generate an initial population of weak
individuals, I prefer zeros to ones in my implementation. This is
done by:

.. code-block:: python

   random.randInt(0, 2) % 2

I then need to have functions than can do selection. In my
implementation, I chose the individuals who have a fitness greater
than the 90 percent of the average fitness. 

.. code-block:: python

    def selection(individuals):
        if len(individuals) == 0:
            return []
        avg = sum([ind.fitness() for ind in individuals])/len(individuals)
        print('Current average is {}'.format(avg))
        return list(filter(lambda x: x.fitness() >= avg * 0.9, individuals))

To do crossovers, I switch out the first 5 items of the
individuals gene array. The function is shown below:

.. code-block:: python

    def crossover(a, b , point=5):
        # two parents get two kids crossed over child
        for gene, index in enumerate(a.genes):
            if index == point:
                break
            temp = a.get_gene(index)
            a.switch(index, b.get_gene(index))
            b.switch(index, temp)
        return [a, b]

For mutations, they have to occur rarely and randomly. To check on
this there is a probability that is passed. For example if one
passes a probability of 100, that means the chance of a mutation
occurring is 0.01. Furthermore, the number of individuals and
which gene to mutate is also randomly generated.

.. code-block:: python

    def mutation(individuals, probability= 10):
        a = random.randint(1, probability)
        if a != 1:
            return individuals
        # do mutation
        no_to_mutate = random.randint(1, len(individuals)-1)
        print('Perform mutation on {} individuals'.format(no_to_mutate))
        for i in range(no_to_mutate):
            b = random.randint(0, len(individuals)-1)
            index = random.randint(0, len(individuals[0].genes)-1);
            value = (individuals[b].get_gene(index) + 1) % 2;
            individuals[b].switch(index, value)
        return individuals

Finally, there needs to be a function that checks if any
individual is has reached the required fitness.

.. code-block:: python

    def check(individuals, threshold=10):
        # Chekc to see if any has met the threshold
        return list(filter(lambda x: x.fitness() >= threshold, individuals))

And here is the function that combines all the functions about to
perform genetic algorithm:

.. code-block:: python

    def perform_ga(generations = 10, size = 500):
        individuals = generate_initial_population(size)
        count = 0;
        while count < generations:
            if (len(individuals) == 0):
                print('Failed after {} generations'.format(count))
                break
            temp_individuals = check(individuals)
            if (len(temp_individuals) !=0):
                print('Solution Found in {} generations'.format(count))
                individuals = temp_individuals
                break

            individuals = selection(mutation(individuals))
            print('Length of individuals {}'.format(len(individuals)))

            # do cross over
            it = iter(individuals)
            individuals = [b for a in zip(it,it) for b in crossover(*a)]
            count = count + 1

        if (count >= generations):
            print('Failed to find optimum in {} generations'.format(count))
        print(individuals)

While implementing the above I got a good grasp on what GA can
achieve. I'm currently thinking of various projects to try out
this on. What's on my mind is using it to optimize arrangement of
furniture in a room. I'll try to implement something cool using
this.

.. TODO: Add gist for the full code.
