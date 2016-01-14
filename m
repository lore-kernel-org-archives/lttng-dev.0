From: John Smith <whalajam@gmail.com>
Subject: channel configuration and data, .ctf files
Date: Wed, 13 Jan 2016 19:14:36 -0800
Message-ID: <CANgVouVLdgA-hWAufvFnjxqgQ1-ec770RnXw39=4vhn0w7YqSQ__44242.0849264183$1452799179$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0544262444=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1aJYMz-00040F-Tt
 for lttng-dev@lists.lttng.org; Wed, 13 Jan 2016 22:14:43 -0500
Received: by mail-ig0-f179.google.com with SMTP id t15so161076376igr.0
 for <lttng-dev@lists.lttng.org>; Wed, 13 Jan 2016 19:14:41 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0544262444==
Content-Type: multipart/alternative; boundary=001a1134b41eb86d3d052942af50

--001a1134b41eb86d3d052942af50
Content-Type: text/plain; charset=UTF-8

Hi,
I have two questions:

1)

I configured a user-space session channel like:
lttng enable-channel  x -u -s y --overwrite -C 4194304 -W 16
--subbuf-size 16384

--tracefile-size = 4MB
--tracefile-count = 16
-subbuf-size = 4 * 4KB (PAGE_SIZE = 4KB)

in
lttng-traces/y_trace-20160113-xxx/ust/uid/1064/64-bit/

I see 32 files:

8192 .. x_trace_chan_0_0
...
8192 .. x_trace_chan_31_0

most of them of 8192 size and one of them (x_trace_chan_8_0) of 147456 size

How these number of files (32) and sizes (mostly 8KB) related to the
desired channel configuration as it looks like they don't, what are the
1-first and 1-nd digit in the _chan_N_M name significance?

2) I'd like to process the generated ctf files using babeltrace but
apparently there are no such files in lttng-trace directory, how can I
generate them, I suppose based on the data in x_trace_chan_N_0 files?

thanks, John

--001a1134b41eb86d3d052942af50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I have two questions:</div><div><br></d=
iv>1)=C2=A0<div><br></div><div>I configured a user-space session channel li=
ke:<div><div>lttng enable-channel =C2=A0x -u -s y --overwrite -C 4194304=C2=
=A0-W 16 --subbuf-size=C2=A016384</div></div><div><br></div><div>--tracefil=
e-size =3D 4MB</div><div>--tracefile-count =3D 16</div><div>-subbuf-size =
=3D 4 * 4KB (PAGE_SIZE =3D 4KB)</div><div><br></div><div>in<br><div>lttng-t=
races/y_trace-20160113-xxx/ust/uid/1064/64-bit/</div><div><br></div><div>I =
see 32 files:</div><div><br></div><div>8192 .. x_trace_chan_0_0<br><div>...=
</div></div></div><div>8192 .. x_trace_chan_31_0<br></div><div><br></div><d=
iv>most of them of 8192 size and one of them (x_trace_chan_8_0) of 147456 s=
ize</div><div><br></div><div>How these number of files (32) and sizes (most=
ly 8KB) related to the desired channel configuration as it looks like they =
don&#39;t, what are the 1-first and 1-nd digit in the _chan_N_M name signif=
icance?=C2=A0</div><div><br></div><div>2) I&#39;d like to process the gener=
ated ctf files using babeltrace but apparently there are no such files in l=
ttng-trace directory, how can I generate them, I suppose based on the data =
in x_trace_chan_N_0 files?</div><div><br></div><div>thanks, John</div><div>=
<br></div></div></div>

--001a1134b41eb86d3d052942af50--


--===============0544262444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0544262444==--
