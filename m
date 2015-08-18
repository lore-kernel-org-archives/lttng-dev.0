From: Jeff Layton <jlayton@poochiereds.net>
Subject: how do I print a value from an array of structs in a
 userspace tracepoint?
Date: Tue, 18 Aug 2015 08:00:30 -0400
Message-ID: <20150818080030.192debe5__31427.1692921922$1439899295$gmane$org@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jlayton@poochiereds.net>) id 1ZRfZJ-0006XM-3U
 for lttng-dev@lists.lttng.org; Tue, 18 Aug 2015 08:00:43 -0400
Received: by qkfj126 with SMTP id j126so56929435qkf.0
 for <lttng-dev@lists.lttng.org>; Tue, 18 Aug 2015 05:00:35 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: thomas.haynes@primarydata.com
List-Id: lttng-dev@lists.lttng.org

I'd like to add a tracepoint to my code that can walk a
dynamically-sized array of structs and print one of the fields from
each struct. For instance, suppose I have an array of structs that
looks like this:

struct foo
{
	int bar;
	int baz;
	...
}

At the time of the tracepoint, I know the number of elements in the
array and can pass that in. Is there any way to have lttng walk the
array of structs and print out only the "bar" field from each?

I've tried using ctf_sequence, but it doesn't seem to do the right
thing. You can't tell it that you want to print out an "int" while
walking an array of differently-sized objects.

Any help is appreciated!
-- 
Jeff Layton <jlayton@poochiereds.net>
