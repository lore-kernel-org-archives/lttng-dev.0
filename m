From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: cds_lfht_count_nodes always returns -1 for
	before/after counts
Date: Sat, 25 Apr 2015 19:32:07 -0400
Message-ID: <20150425193207.5465ca20__39143.1051343263$1430004791$gmane$org@tlielax.poochiereds.net>
References: <20150425172902.08ca0cdc@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vn0-f48.google.com ([209.85.216.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jlayton@poochiereds.net>) id 1Ym9YX-0008Cv-7E
 for lttng-dev@lists.lttng.org; Sat, 25 Apr 2015 19:32:18 -0400
Received: by vnbg1 with SMTP id g1so7814612vnb.2
 for <lttng-dev@lists.lttng.org>; Sat, 25 Apr 2015 16:32:11 -0700 (PDT)
Received: from tlielax.poochiereds.net
 ([2606:a000:1105:8e:3a60:77ff:fe93:a95d])
 by mx.google.com with ESMTPSA id r7sm13609692vdw.23.2015.04.25.16.32.10
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Apr 2015 16:32:11 -0700 (PDT)
In-Reply-To: <20150425172902.08ca0cdc@tlielax.poochiereds.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Sat, 25 Apr 2015 17:29:02 -0400
Jeff Layton <jlayton@poochiereds.net> wrote:

> Hi, I have some code using the cds_lfht infrastructure, and recently
> added a function to check to see if the table was empty using
> cds_lfht_count_nodes. That function just does this:
> 
>         rcu_read_lock();
>         cds_lfht_count_nodes(ht, &before, &count, &after);
>         rcu_read_unlock();
> 
> What I've found though is that when the table is empty and I know that
> there are no concurrent inserts going on, the before and after counters
> are always set to -1 after this call.
> 
> Is that expected behavior? For the record, I'm using this package from
> the Fedora 21 repos:
> 
>     userspace-rcu-0.8.1-5.fc21.x86_64
> 
> Thanks in advance!

Nevermind...I figured out my bug. I had thought it was safe to call
cds_lfht_del on a node that had never been inserted, but it's clearly
not and that throws off the add/del counts.

Sorry for the noise!
-- 
Jeff Layton <jlayton@poochiereds.net>
