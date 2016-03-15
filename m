From: Pinky Singh <pinky.singh17@gmail.com>
Subject: Lttng-java trace event formatting
Date: Tue, 15 Mar 2016 22:58:24 +0530
Message-ID: <CAGXNG7dyo97-ngmJnG7t0v7kcspwAC+Q2k1Cud=Y3KT8jdzZUA__9843.79734513841$1458066550$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3385399203919204956=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B52CBA2AFB
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 17:28:30 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id m184so32708094iof.1
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 10:28:30 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3385399203919204956==
Content-Type: multipart/alternative; boundary=001a113978627affa6052e19b94a

--001a113978627affa6052e19b94a
Content-Type: text/plain; charset=UTF-8

Hi,

I'm using lttng for tracing events in java linux platform.

By default event trace is in format:

[21:28:29.026447729] (+0.006778441)
user
lttng_jul:sys_event: { cpu_id = 10 }, { vtid = 8569, vpid = 8567 }, {
msg = "Obtained reader lock for file",
  logger_name = "test.FileLock",
  class_name = "FileLock",
  method_name = "acquire",
  long_millis = 1458057509025,
  int_loglevel = 500,
  int_threadid = 1 }

how can I change/modify it in following format?

[21:28:29.026447729] (+0.006778441)
user
lttng_jul:sys_event: { cpu_id = 10 }, { vtid = 8569, vpid = 8567 }, {
taskNameField = "test.FileLock",
  eventNameField = "Obtained reader lock for file",
  idField = "FileLock",
  dataField = "acquire" }

In c++ we can give tracepoint arguments to control the fields but in Java
how can I format it?
Regards,
Pinky

--001a113978627affa6052e19b94a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br>

            <br>
           =20

<div>
    <div class=3D"" itemprop=3D"text">

<p>I&#39;m using lttng for tracing events in java linux platform. </p>

<p>By default event trace is in format:</p>

<pre style=3D"" class=3D""><code><span class=3D"">[</span><span class=3D"">=
21</span><span class=3D"">:</span><span class=3D"">28</span><span class=3D"=
">:</span><span class=3D"">29.026447729</span><span class=3D"">]</span><spa=
n class=3D""> </span><span class=3D"">(+</span><span class=3D"">0.006778441=
</span><span class=3D"">)</span><span class=3D"">=20
user=20
lttng_jul</span><span class=3D"">:</span><span class=3D"">sys_event</span><=
span class=3D"">:</span><span class=3D"">=20
</span><span class=3D"">{</span><span class=3D""> cpu_id </span><span class=
=3D"">=3D</span><span class=3D""> </span><span class=3D"">10</span><span cl=
ass=3D""> </span><span class=3D"">},</span><span class=3D"">=20
</span><span class=3D"">{</span><span class=3D""> vtid </span><span class=
=3D"">=3D</span><span class=3D""> </span><span class=3D"">8569</span><span =
class=3D"">,</span><span class=3D""> vpid </span><span class=3D"">=3D</span=
><span class=3D""> </span><span class=3D"">8567</span><span class=3D""> </s=
pan><span class=3D"">},</span><span class=3D"">=20
</span><span class=3D"">{</span><span class=3D""> msg </span><span class=3D=
"">=3D</span><span class=3D""> </span><span class=3D"">&quot;Obtained reade=
r lock for file&quot;</span><span class=3D"">,</span><span class=3D"">=20
  logger_name </span><span class=3D"">=3D</span><span class=3D""> </span><s=
pan class=3D"">&quot;test.FileLock&quot;</span><span class=3D"">,</span><sp=
an class=3D"">=20
  class_name </span><span class=3D"">=3D</span><span class=3D""> </span><sp=
an class=3D"">&quot;FileLock&quot;</span><span class=3D"">,</span><span cla=
ss=3D"">=20
  method_name </span><span class=3D"">=3D</span><span class=3D""> </span><s=
pan class=3D"">&quot;acquire&quot;</span><span class=3D"">,</span><span cla=
ss=3D"">=20
  long_millis </span><span class=3D"">=3D</span><span class=3D""> </span><s=
pan class=3D"">1458057509025</span><span class=3D"">,</span><span class=3D"=
">=20
  int_loglevel </span><span class=3D"">=3D</span><span class=3D""> </span><=
span class=3D"">500</span><span class=3D"">,</span><span class=3D"">=20
  int_threadid </span><span class=3D"">=3D</span><span class=3D""> </span><=
span class=3D"">1</span><span class=3D""> </span><span class=3D"">}</span><=
/code></pre>

<p>how can I change/modify it in following format?</p>

<pre style=3D"" class=3D""><code><span class=3D"">[</span><span class=3D"">=
21</span><span class=3D"">:</span><span class=3D"">28</span><span class=3D"=
">:</span><span class=3D"">29.026447729</span><span class=3D"">]</span><spa=
n class=3D""> </span><span class=3D"">(+</span><span class=3D"">0.006778441=
</span><span class=3D"">)</span><span class=3D"">=20
user=20
lttng_jul</span><span class=3D"">:</span><span class=3D"">sys_event</span><=
span class=3D"">:</span><span class=3D"">=20
</span><span class=3D"">{</span><span class=3D""> cpu_id </span><span class=
=3D"">=3D</span><span class=3D""> </span><span class=3D"">10</span><span cl=
ass=3D""> </span><span class=3D"">},</span><span class=3D"">=20
</span><span class=3D"">{</span><span class=3D""> vtid </span><span class=
=3D"">=3D</span><span class=3D""> </span><span class=3D"">8569</span><span =
class=3D"">,</span><span class=3D""> vpid </span><span class=3D"">=3D</span=
><span class=3D""> </span><span class=3D"">8567</span><span class=3D""> </s=
pan><span class=3D"">},</span><span class=3D"">=20
</span><span class=3D"">{</span><span class=3D""> taskNameField </span><spa=
n class=3D"">=3D</span><span class=3D""> </span><span class=3D"">&quot;test=
.FileLock&quot;</span><span class=3D"">,</span><span class=3D"">=20
  eventNameField </span><span class=3D"">=3D</span><span class=3D""> </span=
><span class=3D"">&quot;Obtained reader lock for file&quot;</span><span cla=
ss=3D"">,</span><span class=3D"">
  idField </span><span class=3D"">=3D</span><span class=3D""> </span><span =
class=3D"">&quot;FileLock&quot;</span><span class=3D"">,</span><span class=
=3D"">
  dataField </span><span class=3D"">=3D</span><span class=3D""> </span><spa=
n class=3D"">&quot;acquire&quot;</span><span class=3D""> </span><span class=
=3D"">}</span></code></pre>

<p>In c++ we can give tracepoint arguments to control the fields but in Jav=
a how can I format it?</p>
    </div></div>Regards,<br></div>Pinky<br></div>

--001a113978627affa6052e19b94a--

--===============3385399203919204956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3385399203919204956==--
