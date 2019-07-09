From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: How to read multiple stream file via babeltrace?
Date: Tue, 9 Jul 2019 21:35:46 +0530
Message-ID: <CAEWVvORCMhp_Xq4cLpVg8yvAdxgreH8WvqZ+57iooMBMFiEFJQ__5192.90067474998$1562688400$gmane$org@mail.gmail.com>
References: <CAEWVvOSCySxpcKw3dmmmW03Sbk1aT-+C3ZR5-LuKgt5w92pkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6983610854360468358=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by lists.lttng.org (Postfix) with ESMTPS id 45jnHh3ZRlz15kS
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jul 2019 12:06:24 -0400 (EDT)
Received: by mail-wr1-x42c.google.com with SMTP id p17so10479812wrf.11
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jul 2019 09:06:24 -0700 (PDT)
In-Reply-To: <CAEWVvOSCySxpcKw3dmmmW03Sbk1aT-+C3ZR5-LuKgt5w92pkYw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6983610854360468358==
Content-Type: multipart/alternative; boundary="000000000000f15e1e058d41bd0e"

--000000000000f15e1e058d41bd0e
Content-Type: text/plain; charset="UTF-8"

Okay. The babeltrace was able to read multiple stream files with one
metadata but for this to get working I had to read so many stream_id in
metadata.
Curretn metadata looks like this:
https://github.com/rmeena840/rtems-tools/commit/5acaea6b5983c903ce904f17220655664b57513b

Now, I want to reduce multiple stream_id in metadata. For this I used
compact header from your CTF documentation [1]. The new metadata looks like
this [2] but babeltrace gives the following error:

[error] Stream 17 is not declared in metadata.
[error] Stream index creation error.
[error] Open file stream error.
[warning] [Context] Cannot open_trace of format ctf at path ctf.
[warning] [Context] cannot open trace "ctf" from ctf for reading.
[error] Cannot open any trace for reading.

[error] opening trace "ctf" for reading.

[error] none of the specified trace paths could be opened.

Any suggestions to resolve this? Thanks

[1] https://diamon.org/ctf/#spec6.1
[2] http://ideone.com/OltS9k

>

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--000000000000f15e1e058d41bd0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Okay. The babeltrace was able to read multiple stream=
 files with one metadata but for this to get working I had to read so many =
stream_id in metadata.</div><div>Curretn metadata looks like this:</div><di=
v><a href=3D"https://github.com/rmeena840/rtems-tools/commit/5acaea6b5983c9=
03ce904f17220655664b57513b">https://github.com/rmeena840/rtems-tools/commit=
/5acaea6b5983c903ce904f17220655664b57513b</a><br></div><div><br></div><div>=
Now, I want to reduce multiple stream_id in metadata. For this I used compa=
ct header from your CTF documentation [1]. The new metadata looks like this=
 [2] but babeltrace gives the following error:</div><div><br></div><div>[er=
ror] Stream 17 is not declared in metadata.<br>[error] Stream index creatio=
n error.<br>[error] Open file stream error.<br>[warning] [Context] Cannot o=
pen_trace of format ctf at path ctf.<br>[warning] [Context] cannot open tra=
ce &quot;ctf&quot; from ctf for reading.<br>[error] Cannot open any trace f=
or reading.<br><br>[error] opening trace &quot;ctf&quot; for reading.<br><b=
r>[error] none of the specified trace paths could be opened.<br></div><div>=
<br></div><div>Any suggestions to resolve this? Thanks</div><div><br></div>=
<div>[1]=C2=A0<a href=3D"https://diamon.org/ctf/#spec6.1">https://diamon.or=
g/ctf/#spec6.1</a></div><div>[2]=C2=A0<a href=3D"http://ideone.com/OltS9k">=
http://ideone.com/OltS9k</a></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_3363556408289764410gmail_signature"><div dir=3D"ltr"><div><div =
dir=3D"ltr"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span =
style=3D"color:rgb(102,102,102)">B. Tech. Computer Science and Engineering,=
<br></span></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"htt=
ps://www.iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">In=
dian Institute of Technology (Indian School of Mines)</a>, Dhanbad</span></=
div></div></div></div></div></div>

--000000000000f15e1e058d41bd0e--

--===============6983610854360468358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6983610854360468358==--
