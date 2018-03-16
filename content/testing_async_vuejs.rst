###################################
Testing Asynchronous Calls in VueJS
###################################

:date: 2018-03-16 15:00
:category: Computer
:tags: projects, programming
:slug: testing-asynchronous-calls-in-vue
:author: John Nduli
:status: published

I frequently use asynchronous calls when coding in vuejs,
especially when I get and send data to an online api. Initially, I
found it difficult to test the asynchronous calls, but as I
learned more, asynchronous tests became painless. I detail the
methods I use to test promises and async calls in this article.
The snippets here assume you are using axios for http requests and
the vuejs project uses vuex for state management.

This is a simple vuex store that can get a random quote or a list
of quotes from `this online api <http://quotesondesign.com/>`_.

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






This is vue component that will display the list of random quotes got:

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

If I want to test the getQuote method, I'll have to figure out how
to make the asyc ajax call to the server. Since the call happens
in another thread, it becomes tricky, because I have to wait for
that thread to finish before testing the result. Luckily, there is
a library called `moxios <https://github.com/axios/moxios>`_. To
set it up on the project, do:

.. code-block:: bash

   npm install moxios --save-dev

With moxios, I can mock the ajax calls (from axios). With this, I
get dummy content that the test can treat similarly to how the
component will treat server results. Moxios also has a wait function, which will pause execution of test until the promise completes. To test the above component with moxios:

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

From the above, I use stubRequest to mock the http request. In the
actual test, I use moxios.wait(), which will wait until the api
call completes before testing the contents of the random quote. I
like this method because it means I get to test the store
indirectly while testing my components.

Instead of moxios.call(), I could use vue's nextTick(), which
also waits for the promise to complete.

.. code-block:: javascript

   it('should show random quote when clicked', (done) => {
     wrapper.find('#get-random').trigger('click')
     wrapper.vm.$nextTick(() => {
       let randomQuote = wrapper.find('#random-quote')
       expect(randomQuote.text()).toContain('At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.')
       done()
     })
   })


Another cleaner method of testing promises is using the library
`flush-promises <https://github.com/kentor/flush-promises>`_. With
flush-promises, the test would look like:

.. code-block:: javascript

   it('should show random quote when clicked', async () => {
     wrapper.find('#get-random').trigger('click')
     await flushPromises()
     let randomQuote = wrapper.find('#random-quote')
     expect(randomQuote.text()).toContain('At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.')
   })

The advantage flushPromises has is that if the component has
multiple asynchronous calls at the same time e.g. call to user api
to confirm if logged in, get list of quotes, get comments, and
for some reason the test does not work, we can just add multiple
flushPromises in the test.


.. code-block:: javascript

   it('should show random quote when clicked', async () => {
     wrapper.find('#get-random').trigger('click')
     await flushPromises()
     await flushPromises()
     let randomQuote = wrapper.find('#random-quote')
     expect(randomQuote.text()).toContain('At this point in experience design evolution, satisfaction ought to be the norm, and delight out to be the goal.')
   })
