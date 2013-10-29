From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-dev Digest, Vol 66, Issue 24
Date: Tue, 29 Oct 2013 16:29:40 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A032C__49219.0441852019$1383064239$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <mailman.575.1383057190.2186.lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VbCAo-0001BG-E9
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 12:29:48 -0400
In-Reply-To: <mailman.575.1383057190.2186.lttng-dev@lists.lttng.org>
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

Date: Tue, 29 Oct 2013 09:50:05 +0800

> However, If one more tracepoint include file(sample_tracepoint2.h) added =
in app, compile failed.
>
> compile:
>
> gcc -I. -o sample sample.c -ldl -llttng-ust
> sample.c: In function main:sample.c:12: error: __tracepoint_sample2___byt=
es_in undeclared (first use in this function)
> sample.c:12: error: (Each undeclared identifier is reported only once
> sample.c:12: error: for each function it appears in.)
>
>   Does LTTng support compiling multiple tracepoint sources with app direc=
tly?  Yes, I can compile multiple tracepoint providers to share libs and li=
nk them to app through TRACEPOINT_PROBE_DYNAMIC_LINKAGE such as what doc/ex=
amples/demo does.

   The problem seems to be olne of missing steps.  First create:

sample_tracepoint.c

#define TRACEPOINT_CREATE_PROBES
#include "sample_tracepoint.h"

   And likewise sample_tracepoint2.c.  In sample.c, remove the #define TRAC=
EPOINT_CREATE_PROBES line.  Finally, compile like this:

$ gcc -I. -c -o sample_tracepoint.o sample_tracepoint.c
$ gcc -I. -c -o sample_tracepoint2.o sample_tracepoint2.c
$ gcc -I. -c -o sample.o sample.c
$ gcc -L/usr/local/lib -o sample sample.o sample_tracepoint.o sample_tracep=
oint2.o -ldl -llttng-ust

   (the -L/usr/local/lib may be unnecessary, depending on your configuratio=
n)

   You can see another example of multiple tracepoint provider use in lttng=
-ust/doc/examples/demo

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
