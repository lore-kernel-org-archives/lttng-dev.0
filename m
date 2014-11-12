From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Strange result from LTTng porting to ARM
Date: Wed, 12 Nov 2014 19:10:56 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBC890A__26899.7522689917$1415819509$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XodJm-0007s7-DF
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 14:11:04 -0500
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
Date: Wed, 12 Nov 2014 23:26:41 +0800
From: J Lin <jmlin.jmlin@gmail.com>

> I've recently ported LTTng to ARM and I can't seem to understand what is =
going wrong with my results. I ran a typical session with "lttng enable-eve=
nt -k -a" for test. Here are the observations:
>
> 1. only "lttng_xxx (e.g, lttng_statedump_interrupts)" are recorded 2. dif=
ferent sessions yield trace on different CPU (the system has 4) but not for=
 all 4, just 1 cpu 3. no recorded session span more than 1 second though I =
would run sleep (i.e., 10s) between "start" and "stop"
>
> This leads me to believe LTTng might be dependent on something in the sys=
tem that isn't present. This is a customized kernel of a client. It has all=
 required configs.
>
> If there is a trigger mechanism after running "lttng start", what would i=
t be? It seems it grabs items initially then doesn't continue. I read in on=
e of the papers that LTTng is architecture dependent. Any help is appreciat=
ed.
>
> Mike

   How exactly did you "port" LTTng to ARM?  As far as I know, you need onl=
y rebuild it there.  Your symptoms lead me to believe you may have not inst=
alled the requisite lttng-modules.  Did you test user-space tracing?

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
