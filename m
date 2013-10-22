From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: UST - Is it possible to merge my source file and
 the tracepoint file?
Date: Tue, 22 Oct 2013 19:29:55 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2679F56D__42254.6837981374$1382470258$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VYheP-0001w3-5W
	for lttng-dev@lists.lttng.org; Tue, 22 Oct 2013 15:30:02 -0400
Content-Language: fr-FR
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

-----Message d'origine-----
Date: Mon, 21 Oct 2013 16:16:30 +0300
From: Amit Margalit <AMITM@il.ibm.com>

Consider the following situation:

I wrote a header (lttng_tp_hdr.h) containing several tracepoints, matching =
some locations I want to instrument in one of my source files (let's call i=
t source.c). I created a C file for this header (lttng_tp_src.c) and compil=
ed it into object. I then compiled source.c into source.o and I link the tw=
o objects together.

This is the standard work mode.

Now I want to automate this procedure, which will cause me to generate new =
C files, and new headers for many of my sources.

How can I rewrite my source.c so it contains everything I need?

Amit Margalit
------------------------------
   Presumably source.c contains at least the tracepoint() calls?  Do you wi=
sh the tracepoint provider (lttng_tp_hdr.h + lttng_tp_src.c) to be statical=
ly included in each linked object (possibly through a shared static library=
 (.a)), or would you rather have your various objects all share a tracepoin=
t provider library (.so)?  In the latter case, would you prefer the tracepo=
int provider library to be a dependency (static awareness: the instrumented=
 apps won't run at all unless they can find the .so) or not (meaning you'll=
 need to LD_PRELOAD the .so to turn tracing on)?  (There's also the case wh=
ere the apps control their own traceability by using dlopen() and dlclose()=
 with the tracepoint provider .so)

   Typically, you need add just the tracepoint() calls and an "#include tra=
cepointprovider.h" in the sources, and you control compilation with the -D =
TRACEPOINT_DEFINE and -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE switches.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
 LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
 Research Gate: <https://www.researchgate.net/profile/Daniel_Thibault/>
