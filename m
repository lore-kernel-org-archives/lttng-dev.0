From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Minor documentation issue with 2.4.0
Date: Thu, 3 Apr 2014 09:58:23 +0300
Message-ID: <OF5E352989.07707A31-ONC2257CAF.00264DED-C2257CAF.002652EA__36823.6233517111$1396516697$gmane$org@il.ibm.com>
References: <OF651759A2.C8A68066-ONC2257CAE.00334115-C2257CAE.0033A0AF@il.ibm.com>
 <CA+jJMxvOS8zo4msc_WMcrO9F=FkVbF4RwkueuKeL=jnjWQRHHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0786522031=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WVbbn-0006Ex-JN
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 02:58:46 -0400
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Thu, 3 Apr 2014 07:58:37 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9CC192190056
 for <lttng-dev@lists.lttng.org>; Thu,  3 Apr 2014 07:58:29 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s336wNSa60227682
 for <lttng-dev@lists.lttng.org>; Thu, 3 Apr 2014 06:58:23 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s337wZA4017453
 for <lttng-dev@lists.lttng.org>; Thu, 3 Apr 2014 01:58:35 -0600
In-Reply-To: <CA+jJMxvOS8zo4msc_WMcrO9F=FkVbF4RwkueuKeL=jnjWQRHHQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, jeremie.galarneau@gmail.com
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0786522031==
Content-Type: multipart/alternative; boundary="=_alternative 0026523AC2257CAF_="

This is a multipart message in MIME format.
--=_alternative 0026523AC2257CAF_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Done. Bug #776: http://bugs.lttng.org/issues/776

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   04/02/2014 05:47 PM
Subject:        Re: [lttng-dev] Minor documentation issue with 2.4.0
Sent by:        jeremie.galarneau@gmail.com



Hi Amit,

Can you open a bug against lttng-tools on bugs.lttng.org? This way
we'll be sure to track the change.

Thanks,
J=E9r=E9mie

On Wed, Apr 2, 2014 at 5:23 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hello,
>
> I ran a command that included an error, and noticed that 'lttng'=20
mentions -j
> in --buffers-pid and --buffers-uid, but nowhere else:
>
> # /usr/bin/lttng enable-channel -u
> Error: Missing channel name.
>
> usage: lttng enable-channel NAME[,NAME2,...] (-u | -k) [OPTIONS]
>
> Options:
>   -h, --help               Show this help
>       --list-options       Simple listing of options
>   -s, --session NAME       Apply to session name
>   -k, --kernel             Apply to the kernel tracer
>   -u, --userspace          Apply to the user-space tracer
>
> Channel options:
>       --discard            Discard event when buffers are full (default)
>       --overwrite          Flight recorder mode
>       --subbuf-size SIZE   Subbuffer size in bytes {+k,+M,+G}
>                                (default UST uid: 131072, UST pid: 4096,
> kernel: 262144, metadata: 4096)
>                                Rounded up to the next power of 2.
>       --num-subbuf NUM     Number of subbufers
>                                (default UST uid: 4, UST pid: 4, kernel:=20
4,
> metadata: 2)
>                                Rounded up to the next power of 2.
>       --switch-timer USEC  Switch timer interval in usec
>                                (default UST uid: 0, UST pid: 0, kernel:=20
0,
> metadata: 0)
>       --read-timer USEC    Read timer interval in usec.
>                                (default UST uid: 0, UST pid: 0, kernel:
> 200000, metadata: 0)
>       --output TYPE        Channel output type (Values: mmap, splice)
>                                (default UST uid: mmap, UST pid: mmap,
> kernel: splice, metadata: mmap)
>       --buffers-uid        Use per UID buffer (-u/-j only)
>       --buffers-pid        Use per PID buffer (-u/-j only)
>       --buffers-global     Use shared buffer for the whole system (-k=20
only)
>   -C, --tracefile-size SIZE
>                            Maximum size of each tracefile within a=20
stream
> (in bytes). 0 means unlimited.
>                                (default: 0)
>   -W, --tracefile-count COUNT
>                            Used in conjunction with -C option, this will
> limit the number
>                            of files created to the specified count. 0=20
means
> unlimited.
>                                (default: 0)
>
> Error: Command error
>
> You can see these 2 lines:
>
>       --buffers-uid        Use per UID buffer (-u/-j only)
>       --buffers-pid        Use per PID buffer (-u/-j only)
>
> But -j is not explained above.
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com



--=_alternative 0026523AC2257CAF_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Done. Bug #776: </font><a href=3Dhttp://=
bugs.lttng.org/issues/776><font size=3D2 color=3Dblue face=3D"sans-serif">h=
ttp://bugs.lttng.org/issues/776</font></a>
<br>
<br><font size=3D2 color=3D#000080 face=3D"sans-serif">Amit Margalit</font>
<br><font size=3D2 color=3D#808000 face=3D"sans-serif">IBM XIV </font><font=
 size=3D2 face=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=3D2 face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font size=3D2 face=3D"sans-serif">Tel. 03</font><font size=3D2 face=3D=
"Arial">-689-7774</font>
<br><font size=3D2 face=3D"Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">J=E9r=E9mie Galarneau &lt;j=
eremie.galarneau@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Amit Margalit/Israel/IBM@IB=
MIL</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">lttng-dev &lt;lttng-dev@lis=
ts.lttng.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">04/02/2014 05:47 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
Minor documentation issue with 2.4.0</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Sent by: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">jeremie.galarneau@gm=
ail.com</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>Hi Amit,<br>
<br>
Can you open a bug against lttng-tools on bugs.lttng.org? This way<br>
we'll be sure to track the change.<br>
<br>
Thanks,<br>
J=E9r=E9mie<br>
<br>
On Wed, Apr 2, 2014 at 5:23 AM, Amit Margalit &lt;AMITM@il.ibm.com&gt;
wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I ran a command that included an error, and noticed that 'lttng' menti=
ons
-j<br>
&gt; in --buffers-pid and --buffers-uid, but nowhere else:<br>
&gt;<br>
&gt; # /usr/bin/lttng enable-channel -u<br>
&gt; Error: Missing channel name.<br>
&gt;<br>
&gt; usage: lttng enable-channel NAME[,NAME2,...] (-u | -k) [OPTIONS]<br>
&gt;<br>
&gt; Options:<br>
&gt; &nbsp; -h, --help &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Show this help<br>
&gt; &nbsp; &nbsp; &nbsp; --list-options &nbsp; &nbsp; &nbsp; Simple listing
of options<br>
&gt; &nbsp; -s, --session NAME &nbsp; &nbsp; &nbsp; Apply to session name<b=
r>
&gt; &nbsp; -k, --kernel &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Apply
to the kernel tracer<br>
&gt; &nbsp; -u, --userspace &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Apply to
the user-space tracer<br>
&gt;<br>
&gt; Channel options:<br>
&gt; &nbsp; &nbsp; &nbsp; --discard &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;Discard event when buffers are full (default)<br>
&gt; &nbsp; &nbsp; &nbsp; --overwrite &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Fli=
ght
recorder mode<br>
&gt; &nbsp; &nbsp; &nbsp; --subbuf-size SIZE &nbsp; Subbuffer size in bytes
{+k,+M,+G}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid: 131072, UST
pid: 4096,<br>
&gt; kernel: 262144, metadata: 4096)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Rounded up to the next power of
2.<br>
&gt; &nbsp; &nbsp; &nbsp; --num-subbuf NUM &nbsp; &nbsp; Number of subbufer=
s<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid: 4, UST pid:
4, kernel: 4,<br>
&gt; metadata: 2)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Rounded up to the next power of
2.<br>
&gt; &nbsp; &nbsp; &nbsp; --switch-timer USEC &nbsp;Switch timer interval
in usec<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid: 0, UST pid:
0, kernel: 0,<br>
&gt; metadata: 0)<br>
&gt; &nbsp; &nbsp; &nbsp; --read-timer USEC &nbsp; &nbsp;Read timer interval
in usec.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid: 0, UST pid:
0, kernel:<br>
&gt; 200000, metadata: 0)<br>
&gt; &nbsp; &nbsp; &nbsp; --output TYPE &nbsp; &nbsp; &nbsp; &nbsp;Channel
output type (Values: mmap, splice)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid: mmap, UST pid:
mmap,<br>
&gt; kernel: splice, metadata: mmap)<br>
&gt; &nbsp; &nbsp; &nbsp; --buffers-uid &nbsp; &nbsp; &nbsp; &nbsp;Use
per UID buffer (-u/-j only)<br>
&gt; &nbsp; &nbsp; &nbsp; --buffers-pid &nbsp; &nbsp; &nbsp; &nbsp;Use
per PID buffer (-u/-j only)<br>
&gt; &nbsp; &nbsp; &nbsp; --buffers-global &nbsp; &nbsp; Use shared buffer
for the whole system (-k only)<br>
&gt; &nbsp; -C, --tracefile-size SIZE<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;Maximum size of each tracefile within a stream<b=
r>
&gt; (in bytes). 0 means unlimited.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default: 0)<br>
&gt; &nbsp; -W, --tracefile-count COUNT<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;Used in conjunction with -C option, this will<br>
&gt; limit the number<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;of files created to the specified count. 0 means=
<br>
&gt; unlimited.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default: 0)<br>
&gt;<br>
&gt; Error: Command error<br>
&gt;<br>
&gt; You can see these 2 lines:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; --buffers-uid &nbsp; &nbsp; &nbsp; &nbsp;Use
per UID buffer (-u/-j only)<br>
&gt; &nbsp; &nbsp; &nbsp; --buffers-pid &nbsp; &nbsp; &nbsp; &nbsp;Use
per PID buffer (-u/-j only)<br>
&gt;<br>
&gt; But -j is not explained above.<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</font></tt></a><tt><font size=3D2><br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
</font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http://ww=
w.efficios.com</font></tt></a><tt><font size=3D2><br>
<br>
</font></tt>
<br>
--=_alternative 0026523AC2257CAF_=--



--===============0786522031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0786522031==--
