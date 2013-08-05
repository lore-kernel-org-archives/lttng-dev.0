From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Mandatory name for some field in a CTF trace
Date: Mon, 5 Aug 2013 15:48:39 -0400
Message-ID: <20130805194839.GA22120__2251.94895542717$1375732176$gmane$org@Krystal>
References: <51FFFF7F.5000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6Qlo-0005Jj-EP
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:48:49 -0400
Content-Disposition: inline
In-Reply-To: <51FFFF7F.5000901@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Hi all,
> 
> I'm writing a CTF writer for perf and I'm discovering that some
> mandatory fields for a CTF trace are not documented.
> We must call the time field "timestamp" and the id field mapping event
> to their description must be "id".

Yes, but they are not mandatory. They can be left out entirely.

> Looking at parser source code, we can find other field like that.
> 
> Would it be interesting to add this information in the CTF spec?

I've put these fields as "examples" in the CTF spec, thinking that some
would evolve into fixed field names in the future as usage confirms that
it's indeed the right choice.

> Or
> should we write a second spec on the side for that kind of information?
> The question we want to answer is "What do I need to put in a CTF file
> to make it possible for a viewer to display it?"

Beware though: a viewer could view a trace that lacks event ID and
timestamp fields entirely. It would be limited to a single even type,
and timestamp would always appear as 0.

Thanks,

Mathieu

> 
> Yannick
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
