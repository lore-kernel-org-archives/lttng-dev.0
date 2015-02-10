From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Tue, 10 Feb 2015 03:02:20 -0500
Message-ID: <54D9BB0C.4040408__6435.86430601335$1423555414$gmane$org@voxpopuli.im>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
 <54CC80CA.2020603@huawei.com> <54D2800B.3050808@voxpopuli.im>
 <54D582E9.4010709@huawei.com> <54D59F4B.4060608@voxpopuli.im>
 <54D5BDCD.5040407@huawei.com> <54D914D0.6000206@voxpopuli.im>
 <54D98F3A.8020202@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YL5m7-0004TL-C7
 for lttng-dev@lists.lttng.org; Tue, 10 Feb 2015 03:02:30 -0500
In-Reply-To: <54D98F3A.8020202@huawei.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wang Nan <wangnan0@huawei.com>
Cc: Xinwei Hu <huxinwei@huawei.com>, "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On 2015-02-09 11:55 PM, Wang Nan wrote:
> On 2015/2/10 4:13, Alexandre Montplaisir wrote:
>> [...]
>>
>> So in this example we could see right away that the average duration is =
around 10-15 ms, but we have some outliers that took more than 20 ms, so it=
 would be interesting to zoom in there to get more details. And eventually =
clicking on one particular occurrence could bring you to the exact point in=
 the trace where it happened (or create bookmarks for the outlier entries, =
etc.)
>>
> Looks good. It should be better if users are able to define their own mat=
ching rules.

Absolutely! We can have pre-defined rules for the known domain (system =

calls, IRQs, and so on), but then it'd be easy to let the user enter an =

event name for the "start" and an event name for the "end".

I was also thinking, we could even use general filters to define what is =

a start and an end event. It would require some refactoring due to the =

way filters are organized at the moment, so it wouldn't be trivial, but =

eventually we may want to get there.

I'm currently working on the side on a prototype of the "event matching" =

table view, I will let you know once I have an initial version working, =

so we can see if/how useful it is.

>
> In addition, do you think about chaining more than 2 events together? Som=
e procedures, such as IO and network, can be traced at different layers, an=
d we are able to chain events caused by same sources together with some cul=
es. Please refer to:
>
> http://comments.gmane.org/gmane.linux.kernel/1883569
>
> Which we are working on.
>

Genevi=E8ve (added in CC) is currently working on virtual machine =

analyses, where we can match events from a kernel trace on a host to a =

kernel trace in a guest, and so on. The "layering" and general matching =

of events should be similar. Maybe she has some ideas if the event =

matching part could be reused somehow?


Cheers,
Alexandre
