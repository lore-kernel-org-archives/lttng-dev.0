From: "Muresan, Heman via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Babeltrace2 sink.ctf.fs creating many subdirectories
Date: Fri, 3 Apr 2020 12:50:07 +0000
Message-ID: <BL0PR04MB5042D065C601970A17A5B2C1CEC70@BL0PR04MB5042.namprd04.prod.outlook.com>
Reply-To: "Muresan, Heman" <hmuresan@ciena.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5484545957723702851=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-00103a01.pphosted.com (mx0a-00103a01.pphosted.com
 [67.231.144.234])
 by lists.lttng.org (Postfix) with ESMTPS id 48v0XS6Ndvz1bS5
 for <lttng-dev@lists.lttng.org>; Fri,  3 Apr 2020 09:05:12 -0400 (EDT)
Received: from pps.filterd (m0174892.ppops.net [127.0.0.1])
 by mx0a-00103a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 033D0DYg029013
 for <lttng-dev@lists.lttng.org>; Fri, 3 Apr 2020 09:05:05 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-00103a01.pphosted.com with ESMTP id 304b3y631k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Fri, 03 Apr 2020 09:05:05 -0400
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5484545957723702851==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR04MB5042D065C601970A17A5B2C1CEC70BL0PR04MB5042namp_"

--_000_BL0PR04MB5042D065C601970A17A5B2C1CEC70BL0PR04MB5042namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using bt2 to combine multiple archives and I'm noticing some weird beha=
vior. Not sure if its something on my end.

I have a bunch of ctf trace archives and I am trying to combine them into o=
ne ctf trace archive, this works fine, but when I try to use this ctf trace=
 plugin again to combine traces I notice that it keeps creating subdirector=
ies. Example:
$ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191121+0000-2020=
0402T191133+0000-779 20200402T191133+0000-20200402T191145+0000-780
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit`.

Now If I try to use this trace to combine again:
$ mv tmp/a46cbfc6c29d/ .
$ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191145+0000-2020=
0402T191157+0000-781 a46cbfc6c29d
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit-0`.
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit`.

Repeating the procress:
$ rm -rf a46cbfc6c29d/
$ mv tmp/a46cbfc6c29d/ .
$ babeltrace2 --output-format=3Dctf --output tmp/ a46cbfc6c29d/ 20200402T19=
1157+0000-20200402T191210+0000-782
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit-1`.
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit`.
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit-0`.

It created a 64-bit-0 and a 64-bit-1 directory, and if I use this newly cre=
ated ctf archive again it will create a 64-bit-2 directory. Eventually the =
directory structure will grow so much that it causes file descriptor proble=
m. Of course, this can be solved by changing the ulimit but that doesn't se=
em like the correct approach, especially since then bt2 will just be using =
more and more resources when its running.

Anyways, I'm just wondering why it keeps creating more and more directories=
, if I combine all four archives in one command it only creates one directo=
ry:
$ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191121+0000-2020=
0402T191133+0000-779 20200402T191133+0000-20200402T191145+0000-780 20200402=
T191145+0000-20200402T191157+0000-781 20200402T191157+0000-20200402T191210+=
0000-782
Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000/u=
st/uid/0/64-bit-2`.

Any help would be appreciated!

Thanks,
Heman


--_000_BL0PR04MB5042D065C601970A17A5B2C1CEC70BL0PR04MB5042namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m using bt2 to combine multiple archives and=
 I&#8217;m noticing some weird behavior. Not sure if its something on my en=
d.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a bunch of ctf trace archives and I am trying=
 to combine them into one ctf trace archive, this works fine, but when I tr=
y to use this ctf trace plugin again to combine traces I notice that it kee=
ps creating subdirectories. Example:<br>
$ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191121&#43;0000-=
20200402T191133&#43;0000-779 20200402T191133&#43;0000-20200402T191145&#43;0=
000-780<o:p></o:p></p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit`.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Now If I try to use this trace to combine again:<o:p=
></o:p></p>
<p class=3D"MsoNormal">$ mv tmp/a46cbfc6c29d/ .<o:p></o:p></p>
<p class=3D"MsoNormal">$ babeltrace2 --output-format=3Dctf --output tmp/ 20=
200402T191145&#43;0000-20200402T191157&#43;0000-781 a46cbfc6c29d<o:p></o:p>=
</p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit-0`.<o:p></o:p></p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit`.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Repeating the procress:<o:p></o:p></p>
<p class=3D"MsoNormal">$ rm -rf a46cbfc6c29d/ <o:p></o:p></p>
<p class=3D"MsoNormal">$ mv tmp/a46cbfc6c29d/ .<o:p></o:p></p>
<p class=3D"MsoNormal">$ babeltrace2 --output-format=3Dctf --output tmp/ a4=
6cbfc6c29d/ 20200402T191157&#43;0000-20200402T191210&#43;0000-782<o:p></o:p=
></p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit-1`.<o:p></o:p></p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit`.<o:p></o:p></p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit-0`.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It created a 64-bit-0 and a 64-bit-1 directory, and =
if I use this newly created ctf archive again it will create a 64-bit-2 dir=
ectory. Eventually the directory structure will grow so much that it causes=
 file descriptor problem. Of course,
 this can be solved by changing the ulimit but that doesn&#8217;t seem like=
 the correct approach, especially since then bt2 will just be using more an=
d more resources when its running.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Anyways, I&#8217;m just wondering why it keeps creat=
ing more and more directories, if I combine all four archives in one comman=
d it only creates one directory:<br>
$ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191121&#43;0000-=
20200402T191133&#43;0000-779 20200402T191133&#43;0000-20200402T191145&#43;0=
000-780 20200402T191145&#43;0000-20200402T191157&#43;0000-781 20200402T1911=
57&#43;0000-20200402T191210&#43;0000-782<o:p></o:p></p>
<p class=3D"MsoNormal">Created CTF trace `tmp//a46cbfc6c29d/flight_recorder=
-20200402T160923&#43;0000/ust/uid/0/64-bit-2`.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any help would be appreciated!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Heman<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BL0PR04MB5042D065C601970A17A5B2C1CEC70BL0PR04MB5042namp_--

--===============5484545957723702851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5484545957723702851==--
