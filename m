From: Francis Rivest <francis.rivest13@gmail.com>
Subject: No kernel tracer available
Date: Thu, 14 May 2015 09:52:06 -0400
Message-ID: <CAG4vvd4Fa2dWpWoO_sJqm+6=K4g9W5Cmvz3LuzkzUAQsGTSPPw__42942.3445290469$1431615467$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0213184887=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.rivest13@gmail.com>) id 1YstYa-00071N-Cb
 for lttng-dev@lists.lttng.org; Thu, 14 May 2015 09:52:15 -0400
Received: by ykft189 with SMTP id t189so24408481ykf.1
 for <lttng-dev@lists.lttng.org>; Thu, 14 May 2015 06:52:07 -0700 (PDT)
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

--===============0213184887==
Content-Type: multipart/alternative; boundary=001a1139c086847d8c05160b0844

--001a1139c086847d8c05160b0844
Content-Type: text/plain; charset=UTF-8

Hello, I'm a student at Polytechnique Montreal and we are trying to use
lttng on ubuntu(Ubuntu 14.04.2 LTS) but always encounter the same problem :

"Error: Unable to list kernel events: Kernel tracer not available"

This happens even though we are root using the command line : sudo su

We reinstalled the packages multiples time for lttng.org and from this
source : https://launchpad.net/~lttng/+archive/ubuntu/ppa/

We are able to create a session but we can't enable event (kernel tracer
not available) or start tracing (error : no channel found).

If someone has advice on how to deal we this, it would be appreciated a lot.

Thank you,

-Francis R.

--001a1139c086847d8c05160b0844
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hello, I&#39;m a studen=
t at Polytechnique Montreal and we are trying to use lttng on ubuntu(Ubuntu=
 14.04.2 LTS) but always encounter the same problem : <br><br></div>&quot;E=
rror: Unable to list kernel events: Kernel tracer not available&quot;<br><b=
r></div>This happens even though we are root using the command line : sudo =
su<br><br></div>We reinstalled the packages multiples time for <a href=3D"h=
ttp://lttng.org">lttng.org</a> and from this source : <a href=3D"https://la=
unchpad.net/~lttng/+archive/ubuntu/ppa/">https://launchpad.net/~lttng/+arch=
ive/ubuntu/ppa/</a><br><br></div>We are able to create a session but we can=
&#39;t enable event (kernel tracer not available) or start tracing (error :=
 no channel found).<br><br></div>If someone has advice on how to deal we th=
is, it would be appreciated a lot.<br><br></div>Thank you, <br><br></div>-F=
rancis R.<br></div>

--001a1139c086847d8c05160b0844--


--===============0213184887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0213184887==--
