From: J Lin <jmlin.jmlin@gmail.com>
Subject: Strange result from LTTng porting to ARM
Date: Wed, 12 Nov 2014 23:26:41 +0800
Message-ID: <CACtA8QRs5yPonuWGJQ6whxiZGaR_LwxgBOrMwfrg8eE9SXcn=g__33340.2277705774$1415806055$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971104581=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jmlin.jmlin@gmail.com>) id 1XoZom-0006nP-4P
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 10:26:50 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so13280534iec.7
 for <lttng-dev@lists.lttng.org>; Wed, 12 Nov 2014 07:26:42 -0800 (PST)
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

--===============1971104581==
Content-Type: multipart/alternative; boundary=001a113ec89ad248450507ab05f2

--001a113ec89ad248450507ab05f2
Content-Type: text/plain; charset=UTF-8

Hello,

I've recently ported LTTng to ARM and I can't seem to understand what is
going wrong with my results. I ran a typical session with "lttng
enable-event -k -a" for test. Here are the observations:

1. only "lttng_xxx (e.g, lttng_statedump_interrupts)" are recorded
2. different sessions yield trace on different CPU (the system has 4)
but not for all 4, just 1 cpu
3. no recorded session span more than 1 second
though I would run sleep (i.e., 10s) between "start" and "stop"

This leads me to believe LTTng might be dependent on something in the
system that isn't present. This is a customized kernel of a client. It has
all required configs.

If there is a trigger mechanism after running "lttng start", what would it
be? It seems it grabs items initially then doesn't continue. I read in one
of the papers that LTTng is architecture dependent. Any help is appreciated.

Thanks,
Mike

--001a113ec89ad248450507ab05f2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I&#39;ve recently ported LTTng t=
o ARM and I can&#39;t seem to understand what is going wrong with my result=
s. I ran a typical session with &quot;lttng enable-event -k -a&quot; for te=
st. Here are the observations:</div><div><br></div><div>1. only &quot;lttng=
_xxx (e.g, lttng_statedump_interrupts)&quot; are recorded<br>2. different s=
essions yield trace on different CPU (the system has 4)</div><div>but not f=
or all 4, just 1 cpu</div><div>3. no recorded session span more than 1 seco=
nd</div><div>though I would run sleep (i.e., 10s) between &quot;start&quot;=
 and &quot;stop&quot;</div><div><br></div><div>This leads me to believe LTT=
ng might be dependent on something in the system that isn&#39;t present. Th=
is is a customized kernel of a client. It has all required configs.</div><d=
iv><br></div><div>If there is a trigger mechanism after running &quot;lttng=
 start&quot;, what would it be? It seems it grabs items initially then does=
n&#39;t continue. I read in one of the papers that LTTng is architecture de=
pendent. Any help is appreciated.</div><div><br></div><div>Thanks,</div><di=
v>Mike</div></div>

--001a113ec89ad248450507ab05f2--


--===============1971104581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1971104581==--
