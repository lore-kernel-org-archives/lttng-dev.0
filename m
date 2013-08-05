From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Mandatory name for some field in a CTF trace
Date: Mon, 05 Aug 2013 16:17:50 -0400
Message-ID: <5200086E.80304__24808.6315383718$1375733963$gmane$org@voxpopuli.im>
References: <51FFFF7F.5000901@gmail.com> <20130805194839.GA22120@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1V6REZ-0006PQ-Rk
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 16:18:33 -0400
In-Reply-To: <20130805194839.GA22120@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 13-08-05 03:48 PM, Mathieu Desnoyers wrote:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> [...]
>> Or
>> should we write a second spec on the side for that kind of information?
>> The question we want to answer is "What do I need to put in a CTF file
>> to make it possible for a viewer to display it?"
> Beware though: a viewer could view a trace that lacks event ID and
> timestamp fields entirely. It would be limited to a single even type,
> and timestamp would always appear as 0.

On a related note, here's how we dealt with it in TMF:
https://bugs.eclipse.org/bugs/show_bug.cgi?id=387039

Cheers,
Alex
