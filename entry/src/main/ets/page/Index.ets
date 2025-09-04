import { rcp } from '@kit.RemoteCommunicationKit';

const API_ENTER_POINT = "https://afdian.com/api";

@Entry
@Component
struct Index {
  @State creators: [] = [];
  @State message: string = '发现';

  async getCreators() {
    const session = rcp.createSession();
    const req = new rcp.Request(`${API_ENTER_POINT}/creator/list?page=1`, "GET")
    try {
      const resp = await session.fetch(req).then(res => res.toJSON())
      console.log(JSON.stringify(resp))
      // this.creators = resp.data.list

    } catch (e) {
      console.error(JSON.stringify(e))
    }
  }

  build() {
    Column() {
      Row() {
        Search({ value: '', placeholder: '输入创作者名字查询' })
          .searchButton("查询")
          // .layoutWeight(1)
          .margin({ left: 12, right: 12 })
          .backgroundColor(Color.Gray)
      }.margin({
        bottom: 12
      })

      Tabs({ index: 0 }) {
        TabContent() {
          Text('首页的内容').fontSize(30)
        }
        .tabBar('首页')

        TabContent() {
          Text('推荐的内容').fontSize(30)
        }
        .tabBar('推荐')

        TabContent() {
          Text('发现的内容').fontSize(30)
        }
        .tabBar('发现')

        TabContent() {
          Text('我的内容').fontSize(30)
        }
        .tabBar("我的")
      }
      .padding({
        left: 12,
        right: 12
      })
      .scrollable(true)
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {

      })

    }
  }
}