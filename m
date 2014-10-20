From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Re: Writing .tp files for lttng-gen-tp
Date: Mon, 20 Oct 2014 15:50:52 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286AE8F__16015.7041078948$1413820307$gmane$org@PAYTON.anl.gov>
References: <48CF5AC71E61DB46B70D0F388054EFFD5A244AEA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <E949C1E351B4914B87A26A5F96E06A9286AE6F@PAYTON.anl.gov>,
 <48CF5AC71E61DB46B70D0F388054EFFD5A244B19@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XgFEk-0004bw-V8
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 11:51:13 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id 107627CC169
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 10:51:05 -0500 (CDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD5A244B19@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks for testing.

I will use these.

Can I add "Suggested-by: Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>"=
 in our open source
BIOSAL git log ?

> ________________________________________
> From: Thibault, Daniel [Daniel.Thibault@drdc-rddc.gc.ca]
> Sent: Monday, October 20, 2014 10:43 AM
> To: Boisvert, Sebastien; lttng-dev@lists.lttng.org
> Subject: RE: [lttng-dev] Writing .tp files for lttng-gen-tp
> -----Message d'origine-----
> De : Boisvert, Sebastien [mailto:boisvert@anl.gov]
> Envoy=E9 : 20 octobre 2014 11:38
> > Are TRACEPOINT_EVENT_CLASS and
> > TRACEPOINT_EVENT_INSTANCE part of the LTTng-UST end user interface (are=
 these stable between release) ?
> >
> > If so, I will gladly give it a try !
>    As far as I can tell, yes, these two macros seem to have been around f=
orever.  I've tested them out on some demo code and they work fine.  They a=
re also compatible with lttng-gen-tp.
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada  <http://www.valcartier.drd=
c-rddc.gc.ca/>
