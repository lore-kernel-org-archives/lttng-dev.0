From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Enable UST probes only in specific process
Date: Thu, 31 Jul 2014 20:14:34 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3CCB3D11__35100.5922457718$1406837745$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XCwkN-0005v9-JM
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 16:14:49 -0400
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
Date: Thu, 31 Jul 2014 14:15:01 -0400
From: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To: Dmitri Shubin <sbn@tbricks.com>

>>> The arguments won't be evaluated if the event is not enabled. =

>>> However, when an event is enabled, the arguments are evaluated =

>>> regardless of the result of the filter's expression evaluation since =

>>> it could be based on the event's content.
>>
>> Yes, exactly.
>> I pass stack trace as an argument to the tracepoint.
>> So it's computed just to be dropped...
>>
>> [...]
>>
>> I.e. here I have separate session per each process I want to trace.
>> It would be easier if I can have channel per process, like e.g.
>> $ lttng enable-channel -p 12345
>>
>> For instance in dtrace I can explicitly specify process I want to =

>> trace by appending its PID to probe name.
>
> You'll be glad to learn that we'll be adding this feature by the end of t=
he year. Probably within the 2.7 release timeframe.

Once this feature is in place, it will mean the tracepoint arguments get ev=
aluated only if the candidate event passes the PID "pre-filter", right?  Wi=
ll we be able to set the pre-filter to PID ranges or sets of values?  I sup=
pose there will be similar filtering options with regard to user IDs?

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
