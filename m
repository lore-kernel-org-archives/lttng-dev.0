From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [RELEASE] Workload-kit 0.1.13
Date: Fri, 31 May 2013 11:48:17 -0400
Message-ID: <CAC6yHM7=H3=L0AOSNw6E9z4VzECTwEa9RMqH=tKUNnWRZf=FHg__9573.11486495218$1370015334$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0195298431=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UiRZ1-0007dS-ON
	for lttng-dev@lists.lttng.org; Fri, 31 May 2013 11:48:23 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so4431381iec.33
	for <lttng-dev@lists.lttng.org>; Fri, 31 May 2013 08:48:18 -0700 (PDT)
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

--===============0195298431==
Content-Type: multipart/alternative; boundary=20cf303bfb622eba7604de058b01

--20cf303bfb622eba7604de058b01
Content-Type: text/plain; charset=ISO-8859-1

Workload-kit is a set of utilities to generate various kind of workloads on
a system, aimed at generating traces that presents recognizable features.
The generated trace set could be used as a basis to validate trace analysis
algorithms. Workload-kit makes it easy to generate the trace set on any
architecture in a reproducible way.

Changelog:
2013-05-31 Workload-kit 0.1.13
* Add cputemp utility to trace sensor temperature with UST (contribution of
Suchakra Sharma)
* Add wk-pipette to show producer and consumer behavior on pipe full/empty
conditions
* Add 3 programs involving synchronization
 * wk-mutex: simple mutex hold
 * wk-imbalance: one thread limits the computation at a barrier
* wk-pipeline: 3 stages pipeline controlled with semaphores
* Modified do_hog function to be closer to the behavior of the counter
function (contribution of Francois Rajotte)
* lttng-simple: new option --enable-libc-wrapper
* lttng-simple: increase UST buffer size to 16MB
* New option to make UST optional (--disable-ust)

The traceset has been generated with the following configuration:
* Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz
* LTTng master (2.2.0-rc2)
* Linux 3.8.0-22-generic
* Includes lttng-modules add-ons

See this link for additional information about tracing userspace memory
allocations with UST:

http://multivax.blogspot.ca/2013/05/tracing-userspace-memory-allocation.html

Sources:  http://secretaire.dorsal.polymtl.ca/~fgiraldeau/workload-kit/
Traceset: http://secretaire.dorsal.polymtl.ca/~fgiraldeau/traceset/
Git repo: https://github.com/giraldeau/workload-kit

--20cf303bfb622eba7604de058b01
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Workload-kit is a set of utilities to generate variou=
s kind of workloads on a system, aimed at generating traces that presents r=
ecognizable features. The generated trace set could be used as a basis to v=
alidate trace analysis algorithms. Workload-kit makes it easy to generate t=
he trace set on any architecture in a reproducible way.</div>
<div><br></div><div>Changelog:</div><div>2013-05-31 Workload-kit 0.1.13</di=
v><div style><span style=3D"white-space:pre">	* Add cputemp utility to trac=
e sensor temperature with UST (contribution of Suchakra=A0Sharma)</span></d=
iv>
<div style><span style=3D"white-space:pre">	* Add wk-pipette to show produc=
er and consumer behavior on pipe full/empty conditions</span><span style=3D=
"white-space:pre"><br></span></div><div style><span style=3D"white-space:pr=
e">	* Add 3 programs involving synchronization<br>
</span></div><div style><span style=3D"white-space:pre">	</span><span style=
=3D"white-space:pre">	* wk-mutex: simple mutex hold<br></span></div><div st=
yle><span style=3D"white-space:pre">	</span><span style=3D"white-space:pre"=
>	* wk-imbalance: one thread limits the computation at a barrier<br>
</span></div><div style><span style=3D"white-space:pre">		* wk-pipeline: 3 =
stages pipeline controlled with semaphores</span><br></div><div style><span=
 style=3D"white-space:pre">	* Modified do_hog function to be closer to the =
behavior of the counter function (contribution of Francois Rajotte)</span><=
br>
</div><div style><span style=3D"white-space:pre">	* lttng-simple: new optio=
n --enable-libc-wrapper</span><span style=3D"white-space:pre"><br></span></=
div><div style><span style=3D"white-space:pre">	* lttng-simple: increase US=
T buffer size to 16MB</span><span style=3D"white-space:pre"><br>
</span></div><div style><span style=3D"white-space:pre">	* New option to ma=
ke UST optional (--disable-ust)<br></span></div><div style><span style=3D"w=
hite-space:pre"><br></span></div><div style>The traceset has been generated=
 with the following configuration:<br>
</div><div style><span style=3D"white-space:pre">	* Intel(R) Core(TM) i7-37=
70 CPU @ 3.40GHz</span><br></div><div><span class=3D"" style=3D"white-space=
:pre">	</span>* LTTng master (2.2.0-rc2)</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Linux 3.8.0-22-generic</div>
<div><span class=3D"" style=3D"white-space:pre">	</span>* Includes lttng-mo=
dules add-ons</div><div><br></div><div style>See this link for additional i=
nformation about tracing userspace memory allocations with UST:</div><div s=
tyle>
<br></div><div style><a href=3D"http://multivax.blogspot.ca/2013/05/tracing=
-userspace-memory-allocation.html">http://multivax.blogspot.ca/2013/05/trac=
ing-userspace-memory-allocation.html</a><br></div><div><br></div><div>Sourc=
es: =A0<a href=3D"http://secretaire.dorsal.polymtl.ca/~fgiraldeau/workload-=
kit/">http://secretaire.dorsal.polymtl.ca/~fgiraldeau/workload-kit/</a><br>
</div><div>Traceset: <a href=3D"http://secretaire.dorsal.polymtl.ca/~fgiral=
deau/traceset/">http://secretaire.dorsal.polymtl.ca/~fgiraldeau/traceset/</=
a></div><div>Git repo: <a href=3D"https://github.com/giraldeau/workload-kit=
">https://github.com/giraldeau/workload-kit</a></div>
</div>

--20cf303bfb622eba7604de058b01--


--===============0195298431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0195298431==--
