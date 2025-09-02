import { rcp } from '@kit.RemoteCommunicationKit';

const API_ENTER_POINT = "https://afdian.com/api";

@Entry
@Component
struct Index {
  @State creators: [] = [];
  @State message: string = '发现创作者';

  async getCreators() {
    const session = rcp.createSession();
    const req = new rcp.Request(`${API_ENTER_POINT}/creator/list?page=1`, "GET")
    try {
      const resp = await session.fetch(req).then(res => res.toJSON())
      console.log(JSON.stringify(resp))
      this.creators = resp.data.list

    } catch (e) {
      console.error(JSON.stringify(e))
    }
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          // this.message = 'Welcome';

        })

      // 新增刷新按钮
      Button('跳转')
        .id('RefreshButton')
        .width(120)
        .height(40)
        .margin({
          top: 20
        })
        .alignRules({
          top: { anchor: 'HelloWorld', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.getCreators()

          // console.info(`Succeeded in clicking the 'Next' button.`)
          // let uiCtx = this.getUIContext();
          // let router = uiCtx.getRouter();
          //
          // router.pushUrl({ url: "pages/Detail" }).then(() => {
          //   console.info('Succeeded in jumping to the second page.')
          // }).catch((err: BusinessError) => {
          //   console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          // })
        })
    }
    .height('100%')
    .width('100%')
  }
}