From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Re: great to read  your presention
Date: Mon, 10 Feb 2014 10:16:44 -0500
Message-ID: <52F8ED5C.5050106__31820.0207002976$1392045484$gmane$org@versatic.net>
References: <E9A0D02B1D74EE4DBF9C09777345E1070382E970@tpeexg06.compal.com>
	<52F5606C.3050709@voxpopuli.im>
	<E9A0D02B1D74EE4DBF9C09777345E107038FD37E@tpeexg06.compal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1WCsbU-00083O-Cn
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 10:17:06 -0500
In-Reply-To: <E9A0D02B1D74EE4DBF9C09777345E107038FD37E@tpeexg06.compal.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David_Ke@compal.com, alexmonthy@voxpopuli.im
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

As Alex said, the CPU usage is still a work in progress. The data is =

available now, but we are working on a view to better show it. It should =

all be available in master in the coming weeks.

As for the wait chain, you may be interested in the critical path =

analysis on LTTng kernel traces. This feature will make it slowly into =

master, but in the meantime, you can try it in our experimental version =

of the tracing RCP available here: =

http://secretaire.dorsal.polymtl.ca/~gbastien/TracingRCP/

You can get the critical path of a process by selecting it in the =

control flow view (with the critical path view open).

Cheers,
Genevi=E8ve


On 02/09/2014 10:49 PM, David_Ke@compal.com wrote:
> Thanks, Alexandre,
>
> Good to hear that.
> Hope to get that soon.
> By the way, some feature to suggest for the utility~
> The control flow is aim to analyze the "long wait time" issue for that
> process,
> IMHO, If it can display the "wait chain" as well as the call stack for ea=
ch
> scheduled thread ,it will be awesome...
>
> Thanks,
>
> David
>
> ----Original Message-----
> From: Alexandre Montplaisir [mailto:alexmonthy@voxpopuli.im]
> Sent: Saturday, February 08, 2014 6:39 AM
> To: Ke. David (TPE)
> Cc: lttng-dev@lists.lttng.org; Genevieve Bastien
> Subject: Re: [lttng-dev] great to read your presention
>
> Hi,
>
> The CPU usage view is still a work-in-progress, but it should be ready in=
 a
> few weeks. We have a bit of infrastructure work to do first.
>
> CC'ing Genevieve, she can probably give us more details about its state.
>
> Cheers,
> Alexandre
>
>
>
> On 14-02-04 08:55 PM, David_Ke@compal.com wrote:
>> Hi Yannick,
>>
>>   =

>>
>> Great to read your deck and it is really a good presentation, from
>> that ,I know more about awesome features of Lttng.
>>
>>   =

>>
>> I was a SR. DEV of MSFT Windows team and was responsible for Xperf and
>> ADK portion in the past, Lttng did catch my eye much more than other
>> utilities (for example perf and oprefile...etc.)
>>
>>   =

>>
>> I download Lttng sample
>> trace(http://lttng.org/files/samples/sample-ctf-trace-20120412.tar.bz2
>> )as
>> well as the RCP version trace viewer(
>> http://secretaire.dorsal.polymtl.ca/~alexmont/tracing-rcp/)but can't
>> find the CPU usage tab in the viewer.
>>
>>   =

>>
>> Is the feature still under development? Where can I got it and have a tr=
y?
>>
>>   =

>>
>> Thanks,
>>
>>   =

>>
>> David Ke
>>
>>
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D This messag=
e may contain information which is
>> private, privileged or confidential of Compal Electronics, Inc.  If you =
are
> not the intended recipient of this message, please notify the sender and
> destroy/delete the message. Any review, retransmission, dissemination or
> other use of, or taking of any action in reliance upon this information, =
by
> persons or entities other than the intended recipient is prohibited.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
