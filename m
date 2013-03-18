From: nathanm2@linux.vnet.ibm.com
Subject: Extracting LTTng ring buffers from a vmcore?
Date: Mon, 18 Mar 2013 19:58:10 -0400
Message-ID: <20130318195810.Horde.Fv0FZZir309RR6oS2LPiI2A__3067.72186090729$1363651161$gmane$org@imap.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nathanm2@linux.vnet.ibm.com>) id 1UHjwf-0005xQ-4w
	for lttng-dev@lists.lttng.org; Mon, 18 Mar 2013 19:58:25 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <nathanm2@linux.vnet.ibm.com>;
	Mon, 18 Mar 2013 19:58:15 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4C7FAC9001A
	for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2013 19:58:12 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r2INwCCD317420
	for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2013 19:58:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r2INwBf3023876
	for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2013 20:58:11 -0300
Received: from imap.linux.ibm.com (maier.raleigh.ibm.com [9.37.253.158])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	r2INwBTE023851
	for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2013 20:58:11 -0300
Content-Disposition: inline
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

While reading through the lib_ring_buffer_commit function I came  
across the following comment:

/*
  * Update used size at each commit. It's needed only for extracting
  * ring_buffer buffers from vmcore, after crash.
  */

I need something exactly like this, but didn't see anything while  
looking through the lttng tools.  Did I miss something?

Thanks
Nate
