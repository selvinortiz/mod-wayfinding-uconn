const defaultState = {
  theme: {
    bg: '#fff',
    text: '#333',
    header: {
      logo: {},
      clock: {}
    },
    main: {},
    footer: {
      nav: {
        item: {
          bg: 'blue',
          text: '#fff',
          active: {
            bg: 'transparent',
            text: 'blue'
          }
        }
      }
    }
  },
  initialized: false
};

export default {
  state: { ...defaultState },
  actions: {
    INIT: context => {
      context.commit('setInitialized', true);
    }
  },
  mutations: {
    setInitialized: (state, initialized = true) => {
      state.initialized = initialized;
    }
  }
};
