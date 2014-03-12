From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: lttng 2.5 upgrade with PPA
Date: Wed, 12 Mar 2014 15:05:44 -0400
Message-ID: <CAC6yHM4TuCp-xspyi3K=2UTh0jkZm38_t7E1QLZjeyZZYbwJmw__39113.7802311734$1394651206$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0591949950=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1WNoTN-0002Wy-Vf
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 15:05:55 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so3019379qaq.10
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 12:05:44 -0700 (PDT)
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

--===============0591949950==
Content-Type: multipart/alternative; boundary=001a11c119820bc66f04f46d86eb

--001a11c119820bc66f04f46d86eb
Content-Type: text/plain; charset=ISO-8859-1

Trying to update today, I got this problem using the daily PPA:

Unpacking liblttng-ust-ctl2:amd64 (from
.../liblttng-ust-ctl2_2.5~pre+bzr1743+pack50+201403102058~ubuntu13.10.1_amd64.deb)
...
dpkg: error processing
/var/cache/apt/archives/liblttng-ust-ctl2_2.5~pre+bzr1743+pack50+201403102058~ubuntu13.10.1_amd64.deb
(--unpack):
 trying to overwrite '/usr/lib/x86_64-linux-gnu/liblttng-ust-ctl.so.2.0.0',
which is also in package liblttng-ust0:amd64
2.4~pre+bzr1731+pack47+201402251322~ubuntu13.10.1
Errors were encountered while processing:
 /var/cache/apt/archives/liblttng-ust-ctl2_2.5~pre+bzr1743+pack50+201403102058~ubuntu13.10.1_amd64.deb
E: Sub-process /usr/bin/dpkg returned an error code (1)

Looks like a packaging bug, the same file belongs to two packages? This is
on Ubuntu 13.10.

Thanks,

Francis

--001a11c119820bc66f04f46d86eb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Trying to update today, I got this problem using the daily=
 PPA:<div><br></div><div><div>Unpacking liblttng-ust-ctl2:amd64 (from .../l=
iblttng-ust-ctl2_2.5~pre+bzr1743+pack50+201403102058~ubuntu13.10.1_amd64.de=
b) ...<br>
</div><div>dpkg: error processing /var/cache/apt/archives/liblttng-ust-ctl2=
_2.5~pre+bzr1743+pack50+201403102058~ubuntu13.10.1_amd64.deb (--unpack):</d=
iv><div>=A0trying to overwrite &#39;/usr/lib/x86_64-linux-gnu/liblttng-ust-=
ctl.so.2.0.0&#39;, which is also in package liblttng-ust0:amd64 2.4~pre+bzr=
1731+pack47+201402251322~ubuntu13.10.1</div>
<div>Errors were encountered while processing:</div><div>=A0/var/cache/apt/=
archives/liblttng-ust-ctl2_2.5~pre+bzr1743+pack50+201403102058~ubuntu13.10.=
1_amd64.deb</div><div>E: Sub-process /usr/bin/dpkg returned an error code (=
1)</div>
</div><div><br></div><div>Looks like a packaging bug, the same file belongs=
 to two packages? This is on Ubuntu 13.10.=A0</div><div><br></div><div>Than=
ks,</div><div><br></div><div>Francis</div></div>

--001a11c119820bc66f04f46d86eb--


--===============0591949950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0591949950==--
