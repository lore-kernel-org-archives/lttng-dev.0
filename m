From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Trace synchronization
Date: Mon, 05 Aug 2013 15:56:10 -0400
Message-ID: <5200035A.6030106__4660.42665434561$1375732661$gmane$org@voxpopuli.im>
References: <CAOSRKdQb3YwEHgasPWx2sHZHCbT5=EqcQSLOAE3ShQUTmqO19Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1V6Qtb-0005dM-UH
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:56:53 -0400
In-Reply-To: <CAOSRKdQb3YwEHgasPWx2sHZHCbT5=EqcQSLOAE3ShQUTmqO19Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sebastiano Spicuglia <spicuglia.sebastiano@gmail.com>, Genevieve Bastien <gbastien+lttng@versatic.net>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

The trace synchronization feature hasn't been merged in the Eclipse
plugin yet, although it's very close. You can look at the latest version
of the patch by Genevi=E8ve Bastien here: https://git.eclipse.org/r/#/c/140=
56/

However, we're currently considering doing a rework of how
experiments/analyzes are defined in the viewer, so this is why some of
those more advanced features are taking some time to land (we'd rather
get the infrastructure right first, rather than having to update every
single feature separately afterwards...)
If you are interested, you can follow this discussion at:
http://dev.eclipse.org/mhonarc/lists//linuxtools-dev/msg02758.html

Some more comments below,

On 13-08-03 05:44 AM, Sebastiano Spicuglia wrote:
> Hello everyone,
>
> I am collecting traces using lttng from different machines.
> I saw here http://www.youtube.com/watch?v=3DYzgRglpXdxQ
> (around 24:06) that it is possible to trace with more details
> the network subsystem and then synchronise different traces.
>
> Even the eclipse page says something about this
> ("Integration of trace synchronization")
> http://www.eclipse.org/linuxtools/projectPages/lttng/
> I read the man of lttng and I look around in the eclipse
> plugin but I didn't find anything about this two features
> (extended network instrumentation and traces sychnronization).
>
> Is the synchronization somehow performed automatically
> by the eclipse plugin =


This is still up in the air. It should be possible to take any two
traces and synchronize them manually (which was the original idea).
However, in the new "analysis" framework, an analysis could specify
which types of traces it expects to have, and also specify if they have
to be synchronized automatically or not.

> and there is no need to enable the extended
> instrumentation of the network subsystem?

This I am not sure. I think the patch to lttng-modules was supposed to
be merged upstream at some point, but I don't know if that was done yet.
Can you enlighten us Genevi=E8ve?

> I have the impression that in the eclipse plugin the term
> "synchronization" is related to the the different sources of
> events on the same machine, am I right?

It could be both on the same machine, or from other hosts. You may
obviously want to synchronize traces from other hosts, which will have
different clocks. But you might also want to synchronize a trace from a
host and from a VM running on the same machine.

> Could you please me provide some resources where I can find
> more information about the synhcronization of traces coming
> from different machines?

I think a couple of articles were written on the subject. Genevi=E8ve has
them stashed somewhere ;)


Cheers,
Alexandre

>
> Thank you in advance for your help
> Regards
> Sebastiano
>
