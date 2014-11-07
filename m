From: Anand Neeli <anand.neeli@gmail.com>
Subject: babeltrace error when reading traces
Date: Fri, 7 Nov 2014 19:56:16 +0530
Message-ID: <CAM5kDqywV5GC84DSC-v6QQTgKWRw5zFPDyVgqOxDbS5K2DgVaw__8255.48499492488$1415370427$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0434937671=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XmkUc-00043W-Au
 for lttng-dev@lists.lttng.org; Fri, 07 Nov 2014 09:26:27 -0500
Received: by mail-wg0-f48.google.com with SMTP id m15so3822963wgh.35
 for <lttng-dev@lists.lttng.org>; Fri, 07 Nov 2014 06:26:17 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0434937671==
Content-Type: multipart/alternative; boundary=047d7bae4666892217050745988e

--047d7bae4666892217050745988e
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm getting following error when reading traces using babeltrace. I have
enabled lttng using relayd and created live session.

I get this error till the time app is running. After app exits, babeltrace
is able to read the traces.

Is there any error in my config? or am i doing anything wrong here?

$>babeltrace
/var/tmp/lttng-traces/node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325/

[warning] Ill-shapen or missing "/* CTF x.y" header for text-only metadata.

[warning] Unsupported CTF specification version 552137642.32558. Trying
anyway.

[error] at line 1: token "": syntax error, unexpected $end

[error] Error creating AST

[warning] Unable to open trace metadata for path
"/var/tmp/lttng-traces/node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325".

[warning] [Context] Cannot open_trace of format ctf at path
/var/tmp/lttng-traces/vevo_re_node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325.

[warning] [Context] cannot open trace
"/var/tmp/lttng-traces/node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325"
from
/var/tmp/lttng-traces/node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325/
for reading.

[error] Cannot open any trace for reading.

[error] opening trace
"/var/tmp/lttng-traces/node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325/"
for reading.

[error] none of the specified trace paths could be opened.



The way i'm enabling lttng:


sudo -H /usr/bin/lttng-relayd -o /var/tmp/lttng-traces -d

sudo -H /usr/bin/lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/
--consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
--consumerd64-libdir /usr/lib64/ -b --no-kernel

sudo -H /usr/bin/lttng create mysession --live 1000000 -U net://$ipaddr

sudo -H /usr/bin/lttng enable-channel mychannel --userspace --buffers-pid
-s mysession --tracefile-size 8388608 --tracefile-count 8

sudo -H /usr/bin/lttng enable-event --channel mychannel --userspace --all
--exclude 'ust_libc:*' -s mysession

sudo -H /usr/bin/lttng start


Thanks,

Anand Neeli

--047d7bae4666892217050745988e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m getting following error when reading t=
races using babeltrace. I have enabled lttng using relayd and created live =
session.</div><div><br></div><div>I get this error till the time app is run=
ning. After app exits, babeltrace is able to read the traces.</div><div><br=
></div><div>Is there any error in my config? or am i doing anything wrong h=
ere?<br><div><br></div><div>







<p class=3D"">$&gt;babeltrace /var/tmp/lttng-traces/node/mysession-20141107=
-051543/ust/pid/logtrace-5797-20141107-061325/</p>
<p class=3D"">[warning] Ill-shapen or missing &quot;/* CTF x.y&quot; header=
 for text-only metadata.</p>
<p class=3D"">[warning] Unsupported CTF specification version 552137642.325=
58. Trying anyway.</p><p class=3D"">[error] at line 1: token &quot;&quot;: =
syntax error, unexpected $end</p>
<p class=3D"">[error] Error creating AST<br></p>
<p class=3D"">[warning] Unable to open trace metadata for path &quot;/var/t=
mp/lttng-traces/node/mysession-20141107-051543/ust/pid/logtrace-5797-201411=
07-061325&quot;.</p>
<p class=3D"">[warning] [Context] Cannot open_trace of format ctf at path /=
var/tmp/lttng-traces/vevo_re_node/mysession-20141107-051543/ust/pid/logtrac=
e-5797-20141107-061325.</p>
<p class=3D"">[warning] [Context] cannot open trace &quot;/var/tmp/lttng-tr=
aces/node/mysession-20141107-051543/ust/pid/logtrace-5797-20141107-061325&q=
uot; from /var/tmp/lttng-traces/node/mysession-20141107-051543/ust/pid/logt=
race-5797-20141107-061325/ for reading.</p><p class=3D"">[error] Cannot ope=
n any trace for reading.</p>
<p class=3D"">[error] opening trace &quot;/var/tmp/lttng-traces/node/mysess=
ion-20141107-051543/ust/pid/logtrace-5797-20141107-061325/&quot; for readin=
g.<br></p>
<p class=3D"">[error] none of the specified trace paths could be opened.<br=
></p><p class=3D""><br></p><p class=3D""><br></p><p class=3D"">The way i&#3=
9;m enabling lttng:</p><p class=3D""><br></p><p class=3D"">sudo -H /usr/bin=
/lttng-relayd -o /var/tmp/lttng-traces -d=C2=A0</p><p class=3D"">sudo -H /u=
sr/bin/lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consu=
merd --consumerd32-libdir /usr/lib/ --consumerd64-path /usr/lib64/lttng/lib=
exec/lttng-consumerd --consumerd64-libdir /usr/lib64/ -b --no-kernel</p><p =
class=3D"">sudo -H /usr/bin/lttng create mysession --live 1000000 -U net://=
$ipaddr</p><p class=3D"">sudo -H /usr/bin/lttng enable-channel mychannel --=
userspace --buffers-pid -s mysession --tracefile-size 8388608 --tracefile-c=
ount 8=C2=A0</p><p class=3D"">sudo -H /usr/bin/lttng enable-event --channel=
 mychannel --userspace --all --exclude &#39;ust_libc:*&#39; -s mysession=C2=
=A0</p><p class=3D"">sudo -H /usr/bin/lttng start<br></p><p class=3D""><br>=
</p><p class=3D"">Thanks,</p><p class=3D"">Anand Neeli</p></div></div></div=
>

--047d7bae4666892217050745988e--


--===============0434937671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0434937671==--
