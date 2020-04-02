From: Aleksander Aleksandrov via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Babeltrace 2.0.2 performance issue
Date: Thu, 2 Apr 2020 16:32:03 +0000
Message-ID: <a095fcdafcf24edf85e047e9c177b0d0@yadro.com>
References: <76e78e538b804aa2b78f320510e8c10d@yadro.com>
 <9ee46aeb-1b9b-c7d4-94ea-c15772bc05eb@efficios.com>
 <5f3249fe30e040b5b4a444fba495de62@yadro.com>
 <6992879d-d139-06f5-d325-02530ad2c1b1@efficios.com>,
 <e21e3ce3-0180-7aa7-aa16-9e889b69269b@efficios.com>
Reply-To: Aleksander Aleksandrov <a.aleksandrov@yadro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7612407340748893677=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
 by lists.lttng.org (Postfix) with ESMTPS id 48tT9n74Dhz1bHj
 for <lttng-dev@lists.lttng.org>; Thu,  2 Apr 2020 12:32:13 -0400 (EDT)
In-Reply-To: <e21e3ce3-0180-7aa7-aa16-9e889b69269b@efficios.com>
Content-Language: ru-RU
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simon.marchi@efficios.com>, "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7612407340748893677==
Content-Language: ru-RU
Content-Type: multipart/alternative;
	boundary="_000_a095fcdafcf24edf85e047e9c177b0d0yadrocom_"

--_000_a095fcdafcf24edf85e047e9c177b0d0yadrocom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hi Simon,


Thank you for your message! Unfortunately, I missed your previous message, =
sorry for this.


I processed the CI's trace logs, I got the following performance: bt2 (140.=
51s) vs bt1 (122.00s). In my opinion, the values are quite similar comparin=
g with my other measurements.


Best regards,

Aleksandr


On 2020-03-13 4:58 p.m., Simon Marchi wrote:
> Hi Aleksander,
>
> I just noticed you did not send your original email to the lttng-dev mail=
ing list,
> please send such request on that mailing list, as it's of public interest=
:
>
>   https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> See my previous response here:
>
>   https://pastebin.com/raw/3Q5PbYXn
>
> Simon
>

Hi Aleksander,

Sorry, I forgot to follow up.  Did you get my last message?

This is the trace we use for benchmarking: https://files.efficios.com/s/pog=
5raGkBkH63y9

Could you try to compare bt1 and bt2 using that trace?

On the CI benchmark system, we get some similar performance with both bt1 a=
nd bt2.  Although
a colleague tried on a recent AMD Ryzen 3700X CPU, and he says bt2 is slowe=
r than bt1 for
him (36s vs 33s).  I'd be curious to know what kind of numbers you get.

Simon

--_000_a095fcdafcf24edf85e047e9c177b0d0yadrocom_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69);">
Hi Simon,</p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69); min-height: 14px;">
<br>
</p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69);">
Thank you for your message! Unfortunately, I missed your previous message, =
sorry for this.</p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69); min-height: 14px;">
<br>
</p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69);">
I processed the CI&#8217;s trace logs, I got the following performance: bt2=
 (140.51s) vs bt1 (122.00s). In my opinion, the values are quite similar co=
mparing with my other measurements.</p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69); min-height: 14px;">
<br>
</p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69);">
Best regards,</p>
<p></p>
<p style=3D"margin-right: 0px; margin-left: 0px; font-stretch: normal; font=
-size: 12px; line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
color: rgb(69, 69, 69);">
Aleksandr</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr">
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 2020-03-13 4:58 p.m., Simon Marchi wrote:<br>
&gt; Hi Aleksander,<br>
&gt; <br>
&gt; I just noticed you did not send your original email to the lttng-dev m=
ailing list,<br>
&gt; please send such request on that mailing list, as it's of public inter=
est:<br>
&gt; <br>
&gt;&nbsp;&nbsp; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev" id=3D"LPlnk568087" previewremoved=3D"true">
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt; <br>
&gt; See my previous response here:<br>
&gt; <br>
&gt;&nbsp;&nbsp; <a href=3D"https://pastebin.com/raw/3Q5PbYXn" id=3D"LPlnk1=
71868" previewremoved=3D"true">
https://pastebin.com/raw/3Q5PbYXn</a><br>
&gt; <br>
&gt; Simon<br>
&gt; <br>
<br>
Hi Aleksander,<br>
<br>
Sorry, I forgot to follow up.&nbsp; Did you get my last message?<br>
<br>
This is the trace we use for benchmarking: <a href=3D"https://files.efficio=
s.com/s/pog5raGkBkH63y9" id=3D"LPlnk502775" previewremoved=3D"true">
https://files.efficios.com/s/pog5raGkBkH63y9</a><br>
<br>
Could you try to compare bt1 and bt2 using that trace?<br>
<br>
On the CI benchmark system, we get some similar performance with both bt1 a=
nd bt2.&nbsp; Although<br>
a colleague tried on a recent AMD Ryzen 3700X CPU, and he says bt2 is slowe=
r than bt1 for<br>
him (36s vs 33s).&nbsp; I'd be curious to know what kind of numbers you get=
.<br>
<br>
Simon<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_a095fcdafcf24edf85e047e9c177b0d0yadrocom_--

--===============7612407340748893677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7612407340748893677==--
