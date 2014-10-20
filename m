From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Writing .tp files for lttng-gen-tp
Date: Mon, 20 Oct 2014 15:43:51 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5A244B19__47020.7676095471$1413819897$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD5A244AEA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <E949C1E351B4914B87A26A5F96E06A9286AE6F@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XgF7l-0004WI-9J
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 11:44:02 -0400
In-Reply-To: <E949C1E351B4914B87A26A5F96E06A9286AE6F@PAYTON.anl.gov>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Boisvert, Sebastien" <boisvert@anl.gov>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Boisvert, Sebastien [mailto:boisvert@anl.gov] =

Envoy=E9=A0: 20 octobre 2014 11:38

> Are TRACEPOINT_EVENT_CLASS and
> TRACEPOINT_EVENT_INSTANCE part of the LTTng-UST end user interface (are t=
hese stable between release) ?
>
> If so, I will gladly give it a try !

   As far as I can tell, yes, these two macros seem to have been around for=
ever.  I've tested them out on some demo code and they work fine.  They are=
 also compatible with lttng-gen-tp.

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
Gouvernement du Canada | Government of Canada  <http://www.valcartier.drdc-=
rddc.gc.ca/>
