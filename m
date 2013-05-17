From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Mariadb+LTTng 2.x
Date: Fri, 17 May 2013 17:28:39 -0400
Message-ID: <5196A107.7070706__10745.9072526128$1368826184$gmane$org@voxpopuli.im>
References: <8E0A14A4C9B95B459AE214584119C1EB417EDCD7@tulip.ad.unb.ca>,
	<20130517184604.GA2020@Krystal>
	<8E0A14A4C9B95B459AE214584119C1EB417EFCEC@tulip.ad.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UdSCv-000737-Vk
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 17:28:58 -0400
In-Reply-To: <8E0A14A4C9B95B459AE214584119C1EB417EFCEC@tulip.ad.unb.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yang Wang <yangw.wang5@unb.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Graeme Johnson <Graeme_Johnson@ca.ibm.com>, Kenneth Kent <ken@unb.ca>, Yannick Brosseau <yannick.brosseau@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Yang,

On 13-05-17 05:21 PM, Yang Wang wrote:
> It seems not this compatibility problem. I have removed all ust1.0 stuffs in the instrumented Mariadb code and
> replaced with lttng-ust 2.x say, tracepoint statements, trancepoint provider files, probes files and use the lib -llttng-ust instead of -lust. Anything I missed?

Mathieu was talking about 2.0 vs 2.1, not 0.x vs 2.x.

If you compiled your application with lttng-ust 2.1, make sure you use
lttng-tools 2.1 to trace it. lttng-tools 2.0 will not work.

>
> Is "libust[7848/7853]: " reported from lttng-tools 2.0? Actually, this is printed from

Yeah I think this is normal, this is old stuff that dates from the 0.x
days, but lttng-ust still prints it that way.


Cheers,
Alex
