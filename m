From: kumar s <skumar.m226@gmail.com>
Subject: Re: lttng-tools build error: non-dynamic relocations
 refer to dynamic symbol lttcomm_inet_tcp_timeout
Date: Tue, 3 Dec 2013 13:53:24 +0530
Message-ID: <CAO_ArvrUNYCd7+1e8hG=fdc84011zMKLjcLg-Ra8qc9Z8ABhgg__44597.925982862$1386059051$gmane$org@mail.gmail.com>
References: <CAO_ArvpzYu+bVKKi956eiObSd+sg-6Aarhy+h5MZqcDk5S-eqg@mail.gmail.com>
	<20131128203243.GC8372@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0218540563=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1VnlGU-0006ch-Cv
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 03:23:31 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu19so9675183vcb.28
	for <lttng-dev@lists.lttng.org>; Tue, 03 Dec 2013 00:23:25 -0800 (PST)
In-Reply-To: <20131128203243.GC8372@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0218540563==
Content-Type: multipart/alternative; boundary=20cf3071c8c2a0390d04ec9d0206

--20cf3071c8c2a0390d04ec9d0206
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I was able to fix this. I downloaded the latest binutils 2.23 and when mips
gcc used the ld from binutils (2.23) , it did not throw any error. The
build went through without any issues.

Do i also need to build lttng modules to start / stop the trace?

Thank you
Skumar.


On Fri, Nov 29, 2013 at 2:02 AM, David Goulet <dgoulet@efficios.com> wrote:

> On 27 Nov (15:37:10), kumar s wrote:
> > Hi,
> >
> > I am getting non dynamic relocation error while trying to build
> > lttng-tools. I have configured the lttng-tools for mips-gcc.
> >
> > Making all in lttng-sessiond
> > make[3]: Entering directory
> > `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
> >   CC     utils.o
> >   CC     trace-kernel.o
> >   CC     kernel.o
> >   CC     context.o
> >   CC     channel.o
> >   CC     event.o
> >   CC     shm.o
> >   CC     consumer.o
> >   CC     session.o
> >   CC     modprobe.o
> >   CC     fd-limit.o
> >   CC     kernel-consumer.o
> >   CC     cmd.o
> >   CC     buffer-registry.o
> >   CC     ht-cleanup.o
> >   CC     snapshot.o
> >   CC     jul.o
> >   CC     main.o
> > main.c: In function 'thread_dispatch_ust_registration':
> > main.c:1564: warning: 'cds_wfq_dequeue_blocking' is deprecated (declared
> at
> >
> /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:88)
> > main.c: In function 'thread_registration_apps':
> > main.c:1917: warning: 'cds_wfq_enqueue' is deprecated (declared at
> >
> /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:76)
> > main.c: In function 'main':
> > main.c:4891: warning: 'cds_wfq_init' is deprecated (declared at
> >
> /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:70)
> >   CCLD   lttng-sessiond
> >
> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mips64-octeon-linux-gnu/bin/ld:
> > non-dynamic relocations refer to dynamic symbol lttcomm_inet_tcp_timeout
> >
> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mips64-octeon-linux-gnu/bin/ld:
> > failed to set dynamic section sizes: Bad value
>
> Looks quite the same here:
> https://sourceware.org/bugzilla/show_bug.cgi?id=10144#c8
>
> It seems that this is a gcc bug with -g. I'm not too familiar with MIPS
> but you could try removing the -g or using "-mplt" as stated in the bug.
>
> Cheers!
> David
>
> > collect2: ld returned 1 exit status
> > make[3]: *** [lttng-sessiond] Error 1
> > make[3]: Leaving directory
> > `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
> > make[2]: *** [all-recursive] Error 1
> > make[2]: Leaving directory
> `/home/shkumar/lttng-tools/lttng-tools/src/bin'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src'
> > make: *** [all-recursive] Error 1
> >
> > Thank you
> > Skumar
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--20cf3071c8c2a0390d04ec9d0206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I was able to fix this. I downlo=
aded the latest binutils 2.23 and when mips gcc used the ld from binutils (=
2.23) , it did not throw any error. The build went through without any issu=
es.</div>
<div><br></div><div>Do i also need to build lttng modules to start / stop t=
he trace?</div><div><br></div><div>Thank you</div><div>Skumar.</div></div><=
div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Nov 29=
, 2013 at 2:02 AM, David Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgo=
ulet@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 27 Nov (15:37:10), kuma=
r s wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am getting non dynamic relocation error while trying to build<br>
&gt; lttng-tools. I have configured the lttng-tools for mips-gcc.<br>
&gt;<br>
</div><div><div class=3D"h5">&gt; Making all in lttng-sessiond<br>
&gt; make[3]: Entering directory<br>
&gt; `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond&#39;<br>
&gt; =A0 CC =A0 =A0 utils.o<br>
&gt; =A0 CC =A0 =A0 trace-kernel.o<br>
&gt; =A0 CC =A0 =A0 kernel.o<br>
&gt; =A0 CC =A0 =A0 context.o<br>
&gt; =A0 CC =A0 =A0 channel.o<br>
&gt; =A0 CC =A0 =A0 event.o<br>
&gt; =A0 CC =A0 =A0 shm.o<br>
&gt; =A0 CC =A0 =A0 consumer.o<br>
&gt; =A0 CC =A0 =A0 session.o<br>
&gt; =A0 CC =A0 =A0 modprobe.o<br>
&gt; =A0 CC =A0 =A0 fd-limit.o<br>
&gt; =A0 CC =A0 =A0 kernel-consumer.o<br>
&gt; =A0 CC =A0 =A0 cmd.o<br>
&gt; =A0 CC =A0 =A0 buffer-registry.o<br>
&gt; =A0 CC =A0 =A0 ht-cleanup.o<br>
&gt; =A0 CC =A0 =A0 snapshot.o<br>
&gt; =A0 CC =A0 =A0 jul.o<br>
&gt; =A0 CC =A0 =A0 main.o<br>
&gt; main.c: In function &#39;thread_dispatch_ust_registration&#39;:<br>
&gt; main.c:1564: warning: &#39;cds_wfq_dequeue_blocking&#39; is deprecated=
 (declared at<br>
&gt; /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/includ=
e/urcu/wfqueue.h:88)<br>
&gt; main.c: In function &#39;thread_registration_apps&#39;:<br>
&gt; main.c:1917: warning: &#39;cds_wfq_enqueue&#39; is deprecated (declare=
d at<br>
&gt; /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/includ=
e/urcu/wfqueue.h:76)<br>
&gt; main.c: In function &#39;main&#39;:<br>
&gt; main.c:4891: warning: &#39;cds_wfq_init&#39; is deprecated (declared a=
t<br>
&gt; /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/includ=
e/urcu/wfqueue.h:70)<br>
&gt; =A0 CCLD =A0 lttng-sessiond<br>
&gt; /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SD=
K/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mi=
ps64-octeon-linux-gnu/bin/ld:<br>
&gt; non-dynamic relocations refer to dynamic symbol lttcomm_inet_tcp_timeo=
ut<br>
&gt; /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SD=
K/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mi=
ps64-octeon-linux-gnu/bin/ld:<br>
&gt; failed to set dynamic section sizes: Bad value<br>
<br>
</div></div>Looks quite the same here:<br>
<a href=3D"https://sourceware.org/bugzilla/show_bug.cgi?id=3D10144#c8" targ=
et=3D"_blank">https://sourceware.org/bugzilla/show_bug.cgi?id=3D10144#c8</a=
><br>
<br>
It seems that this is a gcc bug with -g. I&#39;m not too familiar with MIPS=
<br>
but you could try removing the -g or using &quot;-mplt&quot; as stated in t=
he bug.<br>
<br>
Cheers!<br>
David<br>
<div class=3D"im"><br>
&gt; collect2: ld returned 1 exit status<br>
&gt; make[3]: *** [lttng-sessiond] Error 1<br>
&gt; make[3]: Leaving directory<br>
&gt; `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond&#39;<br>
&gt; make[2]: *** [all-recursive] Error 1<br>
&gt; make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
bin&#39;<br>
&gt; make[1]: *** [all-recursive] Error 1<br>
&gt; make[1]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src&=
#39;<br>
&gt; make: *** [all-recursive] Error 1<br>
&gt;<br>
&gt; Thank you<br>
&gt; Skumar<br>
<br>
</div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
</blockquote></div><br></div>

--20cf3071c8c2a0390d04ec9d0206--


--===============0218540563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0218540563==--
