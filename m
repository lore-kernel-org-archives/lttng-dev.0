From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [babeltrace] About the type read and write
Date: Thu, 23 Aug 2012 22:15:24 -0400
Message-ID: <20120824021524.GA13813__10208.0672201284$1345774559$gmane$org@Krystal>
References: <CANFwon1jpk3PYYd-ufUSCgKf693vApFgt5UbyOFnPczYTrSZcQ@mail.gmail.com>
	<20120823122754.GA23841@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T4jQj-0007UX-Dx
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 22:15:25 -0400
Content-Disposition: inline
In-Reply-To: <20120823122754.GA23841@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hui Zhu <teawater@gmail.com>, jdesfossez@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Hui Zhu (teawater@gmail.com) wrote:
> > Hi,
> > 
> > I just tried to use libbabeltrace to read and write the CTF file.  But
> > I cannot find the api to read some type of CTF for example
> > CTF_TYPE_ENUM, CTF_TYPE_STRUCT.
> 
> AFAIU, the API bt_ctf_get_field_list allows to get the list of
> definitions from a struct, variant, array, or sequence (any compound
> type). Julien, I think the header documentation of this function should
> really be updated, can you look into that ?

Updated in the master branch.

> 
> Indeed, I also cannot see any API to get the enum string from the field.
> Julien, can we add it ?

Now supported in the master branch.

Feedback welcome,

Thanks!

Mathieu

> 
> > And I cannot find the api file to write to the CTF file. (I check the
> > code of babeltrace-log and found that it use the function that is not
> > API)
> 
> Currently, babeltrace only does CTF-to-text and text-log-to-CTF
> conversions. As you noticed, it does not expose API to write into all
> CTF types at this stage.
> 
> There is a prototype I am aware of that does just that (write custom CTF
> files): Javeltrace. See the post here
> http://lists.lttng.org/pipermail/lttng-dev/2012-August/018393.html for
> details.
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Could you help me with it?
> > 
> > Thanks,
> > Hui
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
