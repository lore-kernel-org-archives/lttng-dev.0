From: John Smith <whalajam@gmail.com>
Subject: Re: channel configuration and data, .ctf files
Date: Wed, 13 Jan 2016 21:39:29 -0800
Message-ID: <CANgVouWveYUKujnAZsshBEga_wG4cWzfhSmpxhXnesWhVmvgSg__33484.4448640526$1452799199$gmane$org@mail.gmail.com>
References: <CANgVouVLdgA-hWAufvFnjxqgQ1-ec770RnXw39=4vhn0w7YqSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2041717864=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1aJadC-0004p3-Vz
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 00:39:37 -0500
Received: by mail-ig0-f170.google.com with SMTP id ik10so188867048igb.1
 for <lttng-dev@lists.lttng.org>; Wed, 13 Jan 2016 21:39:34 -0800 (PST)
In-Reply-To: <CANgVouVLdgA-hWAufvFnjxqgQ1-ec770RnXw39=4vhn0w7YqSQ@mail.gmail.com>
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

--===============2041717864==
Content-Type: multipart/alternative; boundary=089e013c69dce20f65052944b5bf

--089e013c69dce20f65052944b5bf
Content-Type: text/plain; charset=UTF-8

Got the answer for my 2-nd question, looks like .ctf is not just one file
but the whole set of files in the trace dir,
thanks, John

On Wed, Jan 13, 2016 at 7:14 PM, John Smith <whalajam@gmail.com> wrote:

> Hi,
> I have two questions:
>
> 1)
>
> I configured a user-space session channel like:
> lttng enable-channel  x -u -s y --overwrite -C 4194304 -W 16
> --subbuf-size 16384
>
> --tracefile-size = 4MB
> --tracefile-count = 16
> -subbuf-size = 4 * 4KB (PAGE_SIZE = 4KB)
>
> in
> lttng-traces/y_trace-20160113-xxx/ust/uid/1064/64-bit/
>
> I see 32 files:
>
> 8192 .. x_trace_chan_0_0
> ...
> 8192 .. x_trace_chan_31_0
>
> most of them of 8192 size and one of them (x_trace_chan_8_0) of 147456 size
>
> How these number of files (32) and sizes (mostly 8KB) related to the
> desired channel configuration as it looks like they don't, what are the
> 1-first and 1-nd digit in the _chan_N_M name significance?
>
> 2) I'd like to process the generated ctf files using babeltrace but
> apparently there are no such files in lttng-trace directory, how can I
> generate them, I suppose based on the data in x_trace_chan_N_0 files?
>
> thanks, John
>
>

--089e013c69dce20f65052944b5bf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Got the answer for my 2-nd question, looks like .ctf is no=
t just one file but the whole set of files in the trace dir,<div>thanks, Jo=
hn</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Wed, Jan 13, 2016 at 7:14 PM, John Smith <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:whalajam@gmail.com" target=3D"_blank">whalajam@gmail.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi,</div>=
<div>I have two questions:</div><div><br></div>1)=C2=A0<div><br></div><div>=
I configured a user-space session channel like:<div><div>lttng enable-chann=
el =C2=A0x -u -s y --overwrite -C 4194304=C2=A0-W 16 --subbuf-size=C2=A0163=
84</div></div><div><br></div><div>--tracefile-size =3D 4MB</div><div>--trac=
efile-count =3D 16</div><div>-subbuf-size =3D 4 * 4KB (PAGE_SIZE =3D 4KB)</=
div><div><br></div><div>in<br><div>lttng-traces/y_trace-20160113-xxx/ust/ui=
d/1064/64-bit/</div><div><br></div><div>I see 32 files:</div><div><br></div=
><div>8192 .. x_trace_chan_0_0<br><div>...</div></div></div><div>8192 .. x_=
trace_chan_31_0<br></div><div><br></div><div>most of them of 8192 size and =
one of them (x_trace_chan_8_0) of 147456 size</div><div><br></div><div>How =
these number of files (32) and sizes (mostly 8KB) related to the desired ch=
annel configuration as it looks like they don&#39;t, what are the 1-first a=
nd 1-nd digit in the _chan_N_M name significance?=C2=A0</div><div><br></div=
><div>2) I&#39;d like to process the generated ctf files using babeltrace b=
ut apparently there are no such files in lttng-trace directory, how can I g=
enerate them, I suppose based on the data in x_trace_chan_N_0 files?</div><=
div><br></div><div>thanks, John</div><div><br></div></div></div>
</blockquote></div><br></div>

--089e013c69dce20f65052944b5bf--


--===============2041717864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2041717864==--
