From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-ust quick start?
Date: Fri, 11 Jan 2013 17:12:49 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E696987596__37780.0902272158$1357942710$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Ttmv5-0003EC-N5
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 17:17:47 -0500
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


   I have this Ubuntu 12.04 machine with the lttng-tools suite installed, a=
nd I now want to quickstart userspace tracing.  Starting at http://lttng.or=
g/quickstart, we're told succinctly that we need to instrument the target a=
pplication (details in the lttng-ust(3) manpage) and then do the actual tra=
cing (Userspace Tracing section of the lttng-tools wiki page).  Fair enough=
.  But the lttng-ust(3) manpage is off to a rocky start.

   The first thing we're told is " to use the lttng-gen-tp(1) tool. See the=
 lttng-gen-tp(1) manpage for explanation."  The catch here is that lttng-ge=
n-tp is NOT part of the basic lttng-tools installation.  The manpage should=
 explain (briefly) that lttng-gen-tp is obtained by installing liblttng-ust=
-dev.  Might as well install liblttng-ctl-dev at the same time, so we have =
a complete LTTng installation.

   The next step in the lttng-ust(3) manpage is to create a tracepoint prov=
ider: "To create a tracepoint provider, within a build tree similar to exam=
ples/easy-ust installed with lttng-ust documentation, a sample_component_pr=
ovider.h for the general layout."  The sentence makes no sense (is it missi=
ng parts?), but even if one glosses over this, the main problem is that the=
re is no easy-ust anywhere to be found within the LTTng installation.  Turn=
ing to the Internet, I find https://github.com/giraldeau/lttng-ust/tree/mas=
ter/doc/examples/easy-ust and grab the handful of files found there.  I the=
n open a console within that directory and invoke make:

gcc -I. -c -o sample.o sample.c
gcc -I. -c -o tp.o tp.c
In file included from /usr/local/include/lttng/ust-tracepoint-event.h:496:0,
                 from /usr/local/include/lttng/tracepoint-event.h:40,
                 from sample_component_provider.h:135,
                 from tp.c:25:
././sample_component_provider.h:128:1: erreur: '__tp_loglevel_entry__sample=
_component___TRACE_WARNING' undeclared here (not in a function)
make: *** [tp.o] Erreur 1

   I think it's telling me it does not recognise the TRACE_WARNING tracepoi=
nt loglevel being defined in sample_component_provider.h (the "TRACEPOINT_L=
OGLEVEL(sample_component, message, TRACE_WARNING)" call), but the name seem=
s legitimate and ust-tracepoint-event.h looks like it should handle the TRA=
CEPOINT_LOGLEVEL* definitions.

   How do I fix this?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
