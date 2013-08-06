From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Re: Trace synchronization
Date: Tue, 06 Aug 2013 09:46:46 -0400
Message-ID: <5200FE46.3050501__27307.7052938335$1375796871$gmane$org@versatic.net>
References: <CAOSRKdQb3YwEHgasPWx2sHZHCbT5=EqcQSLOAE3ShQUTmqO19Q@mail.gmail.com>
	<5200035A.6030106@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1V6hb7-0005LL-J1
	for lttng-dev@lists.lttng.org; Tue, 06 Aug 2013 09:46:55 -0400
In-Reply-To: <5200035A.6030106@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sebastiano Spicuglia <spicuglia.sebastiano@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Sebastiano,

I think the video you mention refers to lttng 0.x, where the tracepoints =

for the network subsystem were fully integrated in lttng-module and =

trace synchronization had been implemented in lttv.

For lttng 2.x, it is still work in progress.  The patch here =

https://git.eclipse.org/r/#/c/14056/ is fully functionnal, it has just =

not yet been merged in Eclipse, but you may use it.

As for lttng-module, the tracepoint exists in master and latest =

releases, but they do not contain enough information to perform =

synchronization.  There are two methods to have information to =

synchronize traces through network:

1-  Use the net_data_experimental branch here =

http://git.dorsal.polymtl.ca/~gbastien?p=3Dlttng-modules.git;a=3Dsummary It =

adds data to the existing tracepoints netif_receive_skb and =

net_dev_queue.  Those patches have been submitted on the lttng-dev =

mailing list and are pending review.  In the meantime, I keep them on my =

personal repository and rebase them once in a while.

2-  Use Francis Giraldeau's addon module here =

https://github.com/giraldeau/lttng-modules/tree/addons  It puts a =

dynamic probe on tcp events so that synchronization uses =

inet_sock_local_in and inet_sock_local_out.  You have to manually =

modprobe lttng-addons and lttng-probe-addons to have those tracepoints =

available.

The trace synchronization patch of the Eclipse plugin includes =

synchronization using the two mentioned methods of lttng kernel traces, =

but it also allows to [easily] add about any other type of =

synchronization, like for ust traces, it just needs events with data =

that can be uniquely matches for both traces.

Here's an article about how it has been implemented in lttv and lttng =

0.x. http://www.dorsal.polymtl.ca/static/publications/poirier-aos.pdf =

The synchronization method is about the same now, it just uses other =

events.  Newer articles on the subject have been written, but they are =

not published yet, so unfortunately I cannot share them here.

Cheers,
Genevi=E8ve


On 08/05/2013 03:56 PM, Alexandre Montplaisir wrote:
> Hi,
>
> The trace synchronization feature hasn't been merged in the Eclipse
> plugin yet, although it's very close. You can look at the latest version
> of the patch by Genevi=E8ve Bastien here: https://git.eclipse.org/r/#/c/1=
4056/
>
> However, we're currently considering doing a rework of how
> experiments/analyzes are defined in the viewer, so this is why some of
> those more advanced features are taking some time to land (we'd rather
> get the infrastructure right first, rather than having to update every
> single feature separately afterwards...)
> If you are interested, you can follow this discussion at:
> http://dev.eclipse.org/mhonarc/lists//linuxtools-dev/msg02758.html
>
> Some more comments below,
>
> On 13-08-03 05:44 AM, Sebastiano Spicuglia wrote:
>> Hello everyone,
>>
>> I am collecting traces using lttng from different machines.
>> I saw here http://www.youtube.com/watch?v=3DYzgRglpXdxQ
>> (around 24:06) that it is possible to trace with more details
>> the network subsystem and then synchronise different traces.
>>
>> Even the eclipse page says something about this
>> ("Integration of trace synchronization")
>> http://www.eclipse.org/linuxtools/projectPages/lttng/
>> I read the man of lttng and I look around in the eclipse
>> plugin but I didn't find anything about this two features
>> (extended network instrumentation and traces sychnronization).
>>
>> Is the synchronization somehow performed automatically
>> by the eclipse plugin
> This is still up in the air. It should be possible to take any two
> traces and synchronize them manually (which was the original idea).
> However, in the new "analysis" framework, an analysis could specify
> which types of traces it expects to have, and also specify if they have
> to be synchronized automatically or not.
>
>> and there is no need to enable the extended
>> instrumentation of the network subsystem?
> This I am not sure. I think the patch to lttng-modules was supposed to
> be merged upstream at some point, but I don't know if that was done yet.
> Can you enlighten us Genevi=E8ve?
>
>> I have the impression that in the eclipse plugin the term
>> "synchronization" is related to the the different sources of
>> events on the same machine, am I right?
> It could be both on the same machine, or from other hosts. You may
> obviously want to synchronize traces from other hosts, which will have
> different clocks. But you might also want to synchronize a trace from a
> host and from a VM running on the same machine.
>
>> Could you please me provide some resources where I can find
>> more information about the synhcronization of traces coming
>> from different machines?
> I think a couple of articles were written on the subject. Genevi=E8ve has
> them stashed somewhere ;)
>
>
> Cheers,
> Alexandre
>
>> Thank you in advance for your help
>> Regards
>> Sebastiano
>>
