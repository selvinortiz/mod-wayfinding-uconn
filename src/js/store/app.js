const defaultState = {
  theme: {
    bg: '#fff',
    text: '#333',
    header: {
      logo: {},
      clock: {
        text: '#999'
      }
    },
    main: {},
    footer: {
      nav: {
        links: [
          { title: 'Places', route: 'places', icon: 'places.svg' },
          { title: 'People', route: 'people', icon: 'people.svg' },
          { title: 'Service', url: 'https://uconn-test.modolabs.net/myuconn/bus_tracker_transloc/index', icon: 'settings.svg' },
          { title: 'Search', route: 'search', icon: 'search.svg' }
        ],
        item: {
          bg: '#fff',
          text: '#3daefc',
          active: {
            bg: 'transparent',
            text: 'blue'
          }
        }
      },
      end: {
        bg: 'background-color: rgba(0, 0, 0, 5);',
        text: 'white'
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
