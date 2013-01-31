From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [RELEASE] Workload-kit 0.1.10
Date: Thu, 31 Jan 2013 14:31:16 -0500
Message-ID: <CAC6yHM4iuFMfYc7-8fAAwdu=9SO6zF05Gt5=0VviCRWaWTZHUw__30203.4503002234$1359660729$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0619436148=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1U0zqz-00032s-NY
	for lttng-dev@lists.lttng.org; Thu, 31 Jan 2013 14:31:21 -0500
Received: by mail-qe0-f49.google.com with SMTP id 5so1438389qea.8
	for <lttng-dev@lists.lttng.org>; Thu, 31 Jan 2013 11:31:16 -0800 (PST)
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

--===============0619436148==
Content-Type: multipart/alternative; boundary=485b397dd4fb9dfe9604d49aab09

--485b397dd4fb9dfe9604d49aab09
Content-Type: text/plain; charset=ISO-8859-1

Workload-kit is a set of utilities to generate various kind of workloads on
a system, aimed at generating traces that presents recognizable features.
The generated trace set could be used as a basis to validate trace
analysis algorithms. Workload-kit makes it easy to generate the trace set
on any architecture in a reproducible way.

Changelog:
2013-01-31 Workload-kit 0.1.10
* Fix temp directory cleanup
* Modified do_hog function to be closer to the behaviour of the counter
function
* Add trace scripts to existing executables
* Add missing heartbeat script
* Add precision about zombie state
* Utility to show reparenting a process to init
* Synchronisation test cases

The traceset has been generated with the following configuration:
* LTTng master
* Linux 3.7
* Includes lttng-modules addons

Sources:  http://secretaire.dorsal.polymtl.ca/~fgiraldeau/workload-kit/
Traceset: http://secretaire.dorsal.polymtl.ca/~fgiraldeau/traceset/
Git repo: https://github.com/giraldeau/workload-kit

--485b397dd4fb9dfe9604d49aab09
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Workload-kit is a set of utilities to generate variou=
s kind of workloads on a=A0system, aimed at generating traces that presents=
 recognizable features. The=A0generated trace set could be used as a basis =
to validate trace analysis=A0algorithms. Workload-kit makes it easy to gene=
rate the trace set on any=A0architecture in a reproducible way.</div>
<div><br></div><div>Changelog:</div><div>2013-01-31 Workload-kit 0.1.10</di=
v><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix temp direct=
ory cleanup</div><div><span class=3D"" style=3D"white-space:pre">	</span>* =
Modified do_hog function to be closer to the behaviour of the counter funct=
ion</div>
<div><span class=3D"" style=3D"white-space:pre">	</span>* Add trace scripts=
 to existing executables</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* Add missing heartbeat script</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Add precision about zombie state</div>
<div><span class=3D"" style=3D"white-space:pre">	</span>* Utility to show r=
eparenting a process to init</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>* Synchronisation test cases</div><div><br></div><div>The tr=
aceset has been generated with the following configuration:</div>
<div><span class=3D"" style=3D"white-space:pre">	</span>* LTTng master</div=
><div><span class=3D"" style=3D"white-space:pre">	</span>* Linux 3.7</div><=
div><span class=3D"" style=3D"white-space:pre">	</span>* Includes lttng-mod=
ules addons</div>
<div><br></div><div>Sources: =A0<a href=3D"http://secretaire.dorsal.polymtl=
.ca/~fgiraldeau/workload-kit/">http://secretaire.dorsal.polymtl.ca/~fgirald=
eau/workload-kit/</a></div><div>Traceset: <a href=3D"http://secretaire.dors=
al.polymtl.ca/~fgiraldeau/traceset/">http://secretaire.dorsal.polymtl.ca/~f=
giraldeau/traceset/</a></div>
<div>Git repo: <a href=3D"https://github.com/giraldeau/workload-kit">https:=
//github.com/giraldeau/workload-kit</a></div><div><br></div></div>

--485b397dd4fb9dfe9604d49aab09--


--===============0619436148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0619436148==--
