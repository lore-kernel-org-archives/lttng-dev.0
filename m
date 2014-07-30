From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Enable UST probes only in specific process
Date: Wed, 30 Jul 2014 16:36:30 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3CCB3AF5__1211.05634975738$1406738261$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XCWrl-0004wy-RX
 for lttng-dev@lists.lttng.org; Wed, 30 Jul 2014 12:36:43 -0400
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
Date: Wed, 30 Jul 2014 17:58:25 +0400
From: Dmitri Shubin <sbn@tbricks.com>

> Is it possible to enable user-space tracepoint in specific process (of gi=
ven PID)?
>
> AFAIU
> lttng enable-event -u prov:probe --filter '$ctx.vpid=3D=3D12345'
> enables probe for all processes and then drops unmatched.
>
> In my case I'm doing rather heavyweight thing in probe (getting stack
> trace) and want to do that only in the process of interest.
>
> Is it possible?
>
> The only way I can do it now is playing with LTTNG_HOME variable setting =
it to different paths for each process.

   I do believe that the filter drops the event before it starts resolving =
its arguments, so filtering should be enough.  Someone more familiar with t=
he internals of LTTng should set us straight either way.

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
