From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: User-space events not creating logs
Date: Tue, 29 Jul 2014 13:19:18 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3CCB28B1__12026.0306903676$1406640001$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XC7JM-0003kS-KD
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 09:19:27 -0400
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
Date: Mon, 28 Jul 2014 14:35:11 -0400
From: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To: RGIAS MUG <rajhindunews@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>

> Is this reproductible on stable 2.5?
>
> J=E9r=E9mie
>
> On Mon, Jul 28, 2014 at 1:36 AM, RGIAS MUG <rajhindunews@gmail.com> wrote:
> >         I am using the lttng (LTTng Trace Control) 2.3.1 - Dominus Vobi=
scum.
> > I have attached the log file with lttng-sessiond and sample user space =

> > tracing application with full verbosity option.
> >
> >        The User space tracing events logs were not available. Same =

> > thing when i tried in ubuntu, there i am able to see some message =

> > communications which was not present in my linux machine having 3.10 ke=
rnel.

   Any chance the instrumented application (./ackermann) is not emitting ev=
ents?

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
