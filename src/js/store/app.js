const defaultState = {
  kioskId: null,
  isMobile: false,
  theme: {
    bg: '#fff',
    text: '#333',
    header: {
      logo: {},
      clock: {
        text: '#999'
      }
    },
    main: {
      peoplePlaceHeader: {
        text: 'blue-800'
      },
      wayfinding: {
        text: 'blue-800'
      },
      directory: {
        text: 'blue-800'
      },
      modMap: {
        text: 'blue-800'
      }
    },
    footer: {
      nav: {
        links: [
          { id: 'places', title: 'Places', route: 'places', icon: 'places.svg' },
          { id: 'people', title: 'People', route: 'people', icon: 'people.svg' },
          { id: 'service', title: 'Service', url: 'https://uconn-test.modolabs.net/myuconn/bus_tracker_transloc/index', icon: 'settings.svg' },
          { id: 'search', title: 'Search', icon: 'search.svg' }
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
  initialized: false,
  searchIsOpen: false
};

export default {
  state: { ...defaultState },
  // actions: {
  //   INIT: context => {
  //     context.commit('setInitialized', true);
  //   }
  // },
  mutations: {
    setInitialized: (state, { isMobile, kioskId }) => {
      state.kioskId = kioskId;
      state.isMobile = isMobile;
      state.initialized = true;
    }
  }
};
