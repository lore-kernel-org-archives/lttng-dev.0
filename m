From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: LTTng unreliable and useless under heavy loaded
	systems?
Date: Mon, 26 Jan 2015 09:46:57 -0500
Message-ID: <CAC6yHM6mMDu=pNMJy4Ys=jGLu8CsabLjD762VDO+A9MJ7uOpQQ__21792.2918069691$1422283673$gmane$org@mail.gmail.com>
References: <54AD5A76.7070004@indel.ch> <54AD654F.4060206@efficios.com>
 <54AE8C05.5070001@indel.ch>
 <983257069.43886.1421439851925.JavaMail.zimbra@efficios.com>
 <54C2019D.1060605@indel.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1545974391=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YFkwQ-0004nl-Ku
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 09:47:10 -0500
Received: by mail-qa0-f53.google.com with SMTP id n4so6938891qaq.12
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 06:46:57 -0800 (PST)
In-Reply-To: <54C2019D.1060605@indel.ch>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Raphael Zulliger <zulliger@indel.ch>
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1545974391==
Content-Type: multipart/alternative; boundary=089e0158b8cac5489b050d8f35f6

--089e0158b8cac5489b050d8f35f6
Content-Type: text/plain; charset=UTF-8

I also had issues with too high trace throughput for the disk. Here are few
other suggestions.

- Use SSD drive
- Raise io priority of consumer daemons with ionice
- Enable only events that are absolutely required
- Reduce CPU frequency to reduce event rate
- Reduce the number of active threads

Good luck,

Francis
On 01/16/2015 09:24 PM, Mathieu Desnoyers wrote:

> If you care about not overwriting your buffers under heavy load, I
> recommend to issue "lttng stop; lttng snapshot record" in order to
> stop tracing before gathering the snapshot. This would lessen the
> chances to overwrite your important trace data due to your heavy
> load.
>
Yeah, that perfectly makes sense. I tried this and it indeed helped to not
loose a single trace anymore! (without 'lttng stop' some 'snapshots' still
didn't contain what I was interested in). For the records, this is how I
currently use LTTng:

    lttng create --snapshot victory
    lttng enable-channel channel0 -k --subbuf-size 16M --num-subbuf 2
    lttng add-context -k -t procname -c channel0
    lttng enable-event -k --all -c channel0
    for i in $(ps -mo tid -p `pgrep lttng-consumerd` | grep -v "TID" | grep
-v "-"); do sudo chrt -f -p 50 $i; done
    lttng start

    chrt -f 50 ./run_my_test-application_here # this app (programmed in
C/C++) performs a 'system("lttng stop; lttng snapshot record; lttng
start");' whenever a certain jitter is reached

    lttng stop
    lttng destroy


I guess the line:
    for i in $(ps -mo tid -p `pgrep lttng-consumerd` | grep -v "TID" | grep
-v "-"); do sudo chrt -f -p 50 $i; done
wouldn't be necessary anymore (with 'lttng stop') but I didn't try that.

Cheers,
Raphael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--089e0158b8cac5489b050d8f35f6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I also had issues with too high trace throughput for the dis=
k. Here are few other suggestions.</p>
<p dir=3D"ltr">- Use SSD drive<br>
- Raise io priority of consumer daemons with ionice<br>
- Enable only events that are absolutely required<br>
- Reduce CPU frequency to reduce event rate<br>
- Reduce the number of active threads</p>
<p dir=3D"ltr">Good luck,</p>
<p dir=3D"ltr">Francis</p>
<div class=3D"gmail_quot&lt;blockquote class=3D" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">On 01/16/2015 09:24 PM, Mathi=
eu Desnoyers wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
If you care about not overwriting your buffers under heavy load, I<br>
recommend to issue &quot;lttng stop; lttng snapshot record&quot; in order t=
o<br>
stop tracing before gathering the snapshot. This would lessen the<br>
chances to overwrite your important trace data due to your heavy<br>
load.<br>
</blockquote>
Yeah, that perfectly makes sense. I tried this and it indeed helped to not =
loose a single trace anymore! (without &#39;lttng stop&#39; some &#39;snaps=
hots&#39; still didn&#39;t contain what I was interested in). For the recor=
ds, this is how I currently use LTTng:<br>
<br>
=C2=A0 =C2=A0 lttng create --snapshot victory<br>
=C2=A0 =C2=A0 lttng enable-channel channel0 -k --subbuf-size 16M --num-subb=
uf 2<br>
=C2=A0 =C2=A0 lttng add-context -k -t procname -c channel0<br>
=C2=A0 =C2=A0 lttng enable-event -k --all -c channel0<br>
=C2=A0 =C2=A0 for i in $(ps -mo tid -p `pgrep lttng-consumerd` | grep -v &q=
uot;TID&quot; | grep -v &quot;-&quot;); do sudo chrt -f -p 50 $i; done<br>
=C2=A0 =C2=A0 lttng start<br>
<br>
=C2=A0 =C2=A0 chrt -f 50 ./run_my_test-application_here # this app (program=
med in C/C++) performs a &#39;system(&quot;lttng stop; lttng snapshot recor=
d; lttng start&quot;);&#39; whenever a certain jitter is reached<br>
<br>
=C2=A0 =C2=A0 lttng stop<br>
=C2=A0 =C2=A0 lttng destroy<br>
<br>
<br>
I guess the line:<br>
=C2=A0 =C2=A0 for i in $(ps -mo tid -p `pgrep lttng-consumerd` | grep -v &q=
uot;TID&quot; | grep -v &quot;-&quot;); do sudo chrt -f -p 50 $i; done<br>
wouldn&#39;t be necessary anymore (with &#39;lttng stop&#39;) but I didn&#3=
9;t try that.<br>
<br>
Cheers,<br>
Raphael<br>
<br>
______________________________<u></u>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-<u></u>bin/mailman/listinfo/lttng-d=
ev</a><br>
</div>

--089e0158b8cac5489b050d8f35f6--


--===============1545974391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1545974391==--
