//
//  Clock.swift
//  Clock
//
//  Created by rilakkuma on 2022/11/12.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
// 数据源
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ClockEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct Clock: Widget {
    let kind: String = "Clock"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ClockEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Clock_Previews: PreviewProvider {
    static var previews: some View {
        ClockEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


// struct CYWidgetCalendarView: View {
//
//    var entry: SimpleEntry
//
//        var body: some View {
//            ZStack {
//                Image(uiImage: entry.data.image)
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//
//                ForEach(1..<13, id: \.self){ i in
//                    let sinX = sin(CGFloat(i)*30.0/180.0*CGFloat.pi)
//                    let sinY = -cos(CGFloat(i)*30.0/180.0*CGFloat.pi)
//                    let color = Color(UIColor(hexStr: entry.data.colorStr))
//                    Text("\(i)")
//                        .foregroundColor(color)
//                        .font(.system(size: RatioLen(14)))
//                        .frame(width: RatioLen(16), height: RatioLen(16), alignment: .center)
//                        .offset(x: 60*sinX, y: 60*sinY)
//                }
//
//                // sec
//                /*
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 2, height: RatioLen(40), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    .offset(y: -10)
//                    .rotationEffect(.init(degrees: Double(entry.clockTime().sec*6)))*/
//
//                // min
//                Rectangle()
//                    .fill(Color.blue)
//                    .frame(width: 2, height: RatioLen(30), alignment: .center)
//                    .offset(y: -15)
//                    .rotationEffect(.init(degrees: Double(entry.clockTime().min*6)))
//
//                let hour = Double(entry.clockTime().min)*0.5 + Double(entry.clockTime().hour)*30.0
//                // hour
//                Rectangle()
//                    .fill(Color.primary)
//                    .frame(width: 2, height: RatioLen(20), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    .offset(y: -10)
//                    .rotationEffect(.init(degrees: Double(hour)))
//                // link 只支持 systemMedium systemLarge
//                /*
//                Link(destination: URL(string: "https://www.baidu.com/")!, label: {
//                        /*@START_MENU_TOKEN@*/Text("Link")/*@END_MENU_TOKEN@*/
//                    })*/
//
//            } // widgetURL 支持全尺寸 推荐
//            .widgetURL(URL(string: "https://www.baidu.com/clock"))
//        }
//}
