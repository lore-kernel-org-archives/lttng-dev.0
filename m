From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Simple question about tracepoint defs
Date: Wed, 2 Jul 2014 15:27:23 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C6DE4__38752.0093856894$1404314906$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1X2MRW-0006La-RQ
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 11:27:36 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Wed, 2 Jul 2014 02:02:25 -0400
From: Sandeep K Chaudhary <babbusandy2006@gmail.com>

> Is it not possible to have two or more trace-point definitions in the sam=
e header file?
>
> Reading from the manual[1] as
>
> "There can be an arbitrary number of tracepoint providers within an
> application, but they must each have their own provider name. Duplicate
> provider names are not allowed.",
>
>I get the idea that it is not possible since each tracepoint provider
>needs to have unique name, and therefore, should be in a different
>header file.
>
>Please confirm if this is the case.
>
> It would be much better for me if it is possible to have multiple
> trace-point definitions in the same header file.
>
> [1] https://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html

   Each tracepoint provider can provide a number of tracepoints.  Ideally, =
each tracepoint header should cover a single tracepoint provider -otherwise=
 you'd end up with two tracepoint providers in lockstep, which is much the =
same as regrouping their tracepoints under a single tracepoint provider, ex=
cept with extra overhead.
   Think of the tracepoint provider as the shared object that implements it=
s tracepoints.  It is a container for tracepoints, very much like a file sy=
stem.  You can have two different tracepoints bearing the same name (identi=
fier) as long as they are in different tracepoint providers, very much like=
 you can have two different files with the same name as long as they are in=
 different folders.
   I hope this clarifies things.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
