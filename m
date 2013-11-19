From: Duncan Sands <baldrick@free.fr>
Subject: Re: New article about Userspace RCU on LWN
Date: Tue, 19 Nov 2013 09:50:39 +0100
Message-ID: <528B265F.1000500__14698.9536974163$1384851095$gmane$org@free.fr>
References: <226335696.70249.1384791646740.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f177.google.com ([74.125.82.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <duncan.sands@gmail.com>) id 1Vih1D-0003AI-PH
	for lttng-dev@lists.lttng.org; Tue, 19 Nov 2013 03:50:50 -0500
Received: by mail-we0-f177.google.com with SMTP id p61so2592211wes.8
	for <lttng-dev@lists.lttng.org>; Tue, 19 Nov 2013 00:50:41 -0800 (PST)
Received: from ?IPv6:2a01:e35:2e83:a840:4427:42b:e61:304f?
	([2a01:e35:2e83:a840:4427:42b:e61:304f])
	by mx.google.com with ESMTPSA id dz5sm3460902wib.7.2013.11.19.00.50.40
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 19 Nov 2013 00:50:40 -0800 (PST)
In-Reply-To: <226335696.70249.1384791646740.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu, nice articles, now I can point my co-workers at it when they ask me
what this RCU stuff is all about :)  I noticed that the article
  http://lwn.net/Articles/573431/
says

"The hash table can then be allocated:

     ht = cds_lfht_new(1, 1, 0, CDS_LFHT_AUTO_RESIZE, NULL);
  The first 1 specifies the initial number of hash buckets in the table, the
  second 1 specifies the minimum number of hash buckets, and the 0 specifies the
  maximum number of hash buckets. All three quantities must be powers of two,
  except for the special case of 0 for the third argument, which specifies an
  unlimited maximum number of hash buckets."

However the rculfhash.h header doesn't say that the third argument can be zero.
All it says is:

  * @max_nr_buckets: the maximum number of hash table buckets allowed.
  *                  (must be power of two)

Best wishes, Duncan.

On 18/11/13 17:20, Mathieu Desnoyers wrote:
> Hi,
>
> Paul McKenney, Lai Jianshan, Josh Triplett and myself just published a series of articles on Userspace RCU on Linux Weekly News. You can find the top-level article at this URL:
>
> https://lwn.net/Articles/573424/
>
> Those articles introduce the Userspace RCU library, explaining how to use RCU and the data structures it contains. Access to those articles is restricted to LWN subscribers for a week after publication, and should be freely available afterward.
>
> Feedback is welcome!
>
> Thanks,
>
> Mathieu
>
