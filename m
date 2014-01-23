From: Anand Neeli <anand.neeli@gmail.com>
Subject: Trace-file size and flight record mode
Date: Thu, 23 Jan 2014 14:06:03 +0530
Message-ID: <CAM5kDqxNbWn094XeCnaMUF9AKVQJ=mquzC=wfcWdbwX1iZ07AQ__43581.3899421648$1390466225$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0532300788=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anand.neeli@gmail.com>) id 1W6Flh-0002rH-FI
	for lttng-dev@lists.lttng.org; Thu, 23 Jan 2014 03:36:12 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so1503176pdj.33
	for <lttng-dev@lists.lttng.org>; Thu, 23 Jan 2014 00:36:03 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0532300788==
Content-Type: multipart/alternative; boundary=047d7b5da891bea8cf04f09f2103

--047d7b5da891bea8cf04f09f2103
Content-Type: text/plain; charset=ISO-8859-1

Hi All,
can anyone help me with these queries. These are related to trace modes and
file sizes.
I use the following commands to trace
    ./lttng enable-channel mychannel --userspace --buffers-pid -s mysession
    ./lttng enable-event --channel mychannel --userspace --all -s mysession

here are my queries
1) Trace file should be limited to some defined size and should be
overwritten after it reaches max size.
I want to retain latest N bytes of traces.
can anyone pls provide more details and the command to enable this?

I see -C and -W options. But will the files be overwritten to maintain
latest traces?
and if i use "-W 4" will it create 4xN bytes of latest traces?

2) Flight recorder mode
If i'm not wrong "Flight recorder mode" continuously overwrite the data in
the memory buffers, instead of flushing it to a file on disk.
How to flush this memory buffer to file to see the traces or is there a way
to read this memory?

Thanks,
Anand Neeli

--047d7b5da891bea8cf04f09f2103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><span style=3D"font-family:tahoma,sans-serif">=
can anyone help me with these queries. These are related to trace modes and=
 file sizes.</span><br></div><div><span style=3D"font-family:tahoma,sans-se=
rif">I use the following commands to trace=A0</span></div>
<div><span style=3D"font-family:tahoma,sans-serif">=A0 =A0 ./lttng enable-c=
hannel mychannel --userspace --buffers-pid -s mysession</span></div><div><s=
pan style=3D"font-family:tahoma,sans-serif">=A0 =A0 ./lttng enable-event --=
channel mychannel --userspace --all -s mysession</span></div>
<div><span style=3D"font-family:tahoma,sans-serif"><br></span></div><div><s=
pan style=3D"font-family:tahoma,sans-serif">here are my queries</span></div=
><div><span style=3D"font-family:tahoma,sans-serif">1) Trace file should be=
 limited to some defined size and should be overwritten after it reaches ma=
x size.</span></div>
<div><span style=3D"font-family:tahoma,sans-serif">I want to retain latest =
N bytes of traces.</span></div><div><span style=3D"font-family:tahoma,sans-=
serif">can anyone pls provide more details and the command to enable this?<=
/span></div>
<div><span style=3D"font-family:tahoma,sans-serif"><br></span></div><div><s=
pan style=3D"font-family:tahoma,sans-serif">I see -C and -W options. But wi=
ll the files be overwritten to maintain latest traces?</span></div><div><sp=
an style=3D"font-family:tahoma,sans-serif">and if i use &quot;-W 4&quot; wi=
ll it create 4xN bytes of latest traces?</span></div>
<div><span style=3D"font-family:tahoma,sans-serif"><br></span></div><div><s=
pan style=3D"font-family:tahoma,sans-serif">2) Flight recorder mode</span><=
/div><div><span style=3D"font-family:tahoma,sans-serif">If i&#39;m not wron=
g &quot;Flight recorder mode&quot; continuously overwrite the data in the m=
emory buffers, instead of flushing it to a file on disk.</span></div>
<div><span style=3D"font-family:tahoma,sans-serif">How to flush this memory=
 buffer to file to see the traces or is there a way to read this memory?=A0=
</span></div><div><br></div><div><span style=3D"font-family:tahoma,sans-ser=
if">Thanks,</span></div>
<div>Anand Neeli</div></div>

--047d7b5da891bea8cf04f09f2103--


--===============0532300788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0532300788==--
