###################################
Testing Asynchronous Calls in VueJS
###################################

:date: 2018-01-14 15:00
:category: Computer
:slug: testing-asynchronous-calls-in-vue
:author: John Nduli
:status: draft

When coding in vuejs, I use asynchronous calls a lot, especially
when getting and sending data to an online api. Initially, testing
this was really difficult but as I leaned more and more, it's
become almost painless. I'll detail the options of testing
promises and async calls which I use with vuejs.

The snippets here assume you are using axios for http requests and
the vuejs project uses vuex for state management.

Let's take this as our store:

.. code-block:: javascript

    import Vue from 'vue'
    import Vuex from 'vuex'

    Vue.use(Vuex)

    export default new Vuex.Store({

      state: {
        quotes: [],
        randomQuote: null
      },
      mutations: {
        setQuotes (state, newQuotes) {
          state.quotes = newQuotes
        },
        setRandomQuote (state, randomQuote) {
          state.randomQuote = randomQuote
          console.log(state.randomQuote)
        }
      },
      actions: {
        getQuotes ({commit}) {
          return Vue.axios.get('http://quotesondesign.com/wp-json/posts')
            .then((response) => {
              commit('setQuotes', response.data)
            })
        },
        getRandomQuote ({ commit }) {
          return Vue.axios.get('http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1')
            .then((response) => {
              commit('setRandomQuote', response.data)
            })
        }
      }
    })





And this is one of our views that gets random quotes:

.. code-block:: javascript


    <template>
      <div>
        <h2>Random Quote</h2>
        <div id='random-quote' v-for="item in randomQuote" :key="item.ID">
          <h2>{{ item.title }}</h2>
          {{ item.content }}
        </div>
        <div v-if="randomQuote === null">It is null</div>
        <button id='get-random' v-on:click="getQuote">GetRandomQuote</button>
      </div>
    </template>
    <script>
    import { mapState } from 'vuex'

    export default {
      name: 'GetQuotes',
      // created: function () {
      // this.$store.dispatch('getRandomQuote')
      // },
      computed: mapState({
        randomQuote: state => state.randomQuote
      }),
      methods: {
        getQuote: function () {
          this.$store.dispatch('getRandomQuote')
        }
      }
    }
    </script>

To test the getQuotes methods will be a bit tricky. This is
because we first have a call to an api server, and this call is
asynchronous. Luckily, there is a library called `moxios
<https://github.com/axios/moxios>`_. To set it up on the project,
do:

.. code-block:: bash

   npm install moxios --save-dev

Moxios provides a pretty neat way of mocking axios calls so that
we get dummy content that can be rendered as though it was the
real thing. It also provides a means on waiting for axios promises
to finish. So to test the above component using moxios:

.. code-block:: javascript

    import Vue from 'vue'
    import Vuex from 'vuex'
    import { mount } from 'vue-test-utils'
    import RandomQuote from '@/components/RandomQuote'
    import store from '@/store'
    import axios from 'axios'
    import VueAxios from 'vue-axios'
    import moxios from 'moxios'

    Vue.use(Vuex)
    Vue.use(VueAxios, axios)

    describe('Login.vue', () => {
      let wrapper

      beforeEach(() => {
        moxios.install()

        moxios.stubRequest('http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1', {
          status: 200,
          response: [
            {
              ID: 1622,
              title: 'Stephen Anderson',
              content: '<p>At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.</p>\n'
            }
          ]
        })

        wrapper = mount(RandomQuote, {
          store
        })
      })

      afterEach(() => {
        moxios.uninstall()
      })

      it('should show random quote when clicked', (done) => {
        wrapper.find('#get-random').trigger('click')
        moxios.wait(() => {
          let randomQuote = wrapper.find('#random-quote')
          expect(randomQuote.text()).toContain('At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.')
          done()
        })
      })
    })

From the above, we can see the stubRequest whicn mocks the axios
api call. Furthermore, we find the moxios.wait() call which waits
for the call to complete before testing the contents of the random
quote. I really like this method because it means I can also test
the store indirectly when testing the components.

We could also use nextTick to test the promise like this:

.. code-block:: javascript

   it('should show random quote when clicked', (done) => {
     wrapper.find('#get-random').trigger('click')
     wrapper.vm.$nextTick(() => {
       let randomQuote = wrapper.find('#random-quote')
       expect(randomQuote.text()).toContain('At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.')
       done()
     })
   })


Suppose our component had a created hook, and within this an
asychronous task was called that returned quotes like:

.. code-block:: javascript

    <template>
      <div>
        <h2>Quotes</h2>
        <div v-for="item in quotes" :key="item.ID">
          <h2>{{ item.title }}</h2>
          {{ item.content }}
        </div>
        <h2>Random Quote</h2>
        <div id='random-quote' v-for="item in randomQuote" :key="item.ID">
          <h2>{{ item.title }}</h2>
          {{ item.content }}
        </div>
        <div v-if="randomQuote === null">It is null</div>
        <button id='get-random' v-on:click="getQuote">GetRandomQuote</button>
      </div>
    </template>
    <script>
    import { mapState } from 'vuex'

    export default {
      name: 'GetQuotes',
      created: function () {
        this.$store.dispatch('getQuotes')
      },
      computed: mapState({
        randomQuote: state => state.randomQuote,
        quotes: state => state.quotes
      }),
      methods: {
        getQuote: function () {
          this.$store.dispatch('getRandomQuote')
        }
      }
    }
    </script>

Testing the created function is easy. We just stub the getQuotes
url in our beforeEach call like:

.. code-block:: javascript

   beforeEach(() => {
     moxios.install()

     moxios.stubRequest('http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1', {
       status: 200,
       response: [
         {
           ID: 1622,
           title: 'Stephen Anderson',
           content: '<p>At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.</p>\n'
         }
       ]
     })

     moxios.stubRequest('http://quotesondesign.com/wp-json/posts', {
       status: 200,
       response: [
         {
           ID: 2328,
           content: '<p>Everything we do communicates.</p>\n',
           title: 'Pete Episcopo'
         },
         {
           ID: 2326,
           content: '<p>The only &#8220;intuitive&#8221; interface is the nipple. After that it&#8217;s all learned.</p>\n',
           title: 'Bruce Ediger'
         }
       ]
     })

     wrapper = mount(RandomQuote, {
       store
     })
   })

And to test it, we have this method:

.. code-block:: javascript

   it('should show quotes on created', (done) => {
     moxios.wait(() => {
       let quotes = wrapper.findAll('#quotes')
       console.log(quotes)
       expect(quotes.length).toEqual(2)
       done()
     })
   })

Another cleaner method of testing promises is using the library
`flush-promises <https://github.com/kentor/flush-promises>`_. With
this for example the test would look like this:


.. code-block:: javascript

   it('should show quotes on created', async () => {
     await flushPromises()
     let quotes = wrapper.findAll('#quotes')
     console.log(quotes)
     expect(quotes.length).toEqual(2)
   })
