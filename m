From: Beatriz Aguilar <beatriz.aguilar@bsc.es>
Subject: Lttng user application tracing
Date: Tue, 05 May 2015 18:55:40 +0200
Message-ID: <5548F60C.7000403__17897.7723503069$1430851774$gmane$org@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mao.bsc.es ([84.88.52.34] helo=opsmail01.bsc.es)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <beatriz.aguilar@bsc.es>) id 1Ypg8G-0001v9-U5
 for lttng-dev@lists.lttng.org; Tue, 05 May 2015 12:55:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by opsmail01.bsc.es (Postfix) with ESMTP id 4BEEDFA5B3
 for <lttng-dev@lists.lttng.org>; Tue,  5 May 2015 18:55:38 +0200 (CEST)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27728-04 for <lttng-dev@lists.lttng.org>;
 Tue,  5 May 2015 18:55:37 +0200 (CEST)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by opsmail01.bsc.es (Postfix) with ESMTPS id 3E686C45C4
 for <lttng-dev@lists.lttng.org>; Tue,  5 May 2015 18:55:37 +0200 (CEST)
Received: (from filter@localhost)
 by opswc01.bsc.es (8.13.6/8.13.6/Submit) id t45GtbL3032747
 for lttng-dev@lists.lttng.org; Tue, 5 May 2015 18:55:37 +0200
Received: from [84.88.50.155] (bsccs318.int.bsc.es [84.88.50.155])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by opsmail01.bsc.es (Postfix) with ESMTPSA id 1D9152C888
 for <lttng-dev@lists.lttng.org>; Tue,  5 May 2015 18:55:37 +0200 (CEST)
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

Hi,

I am trying to trace a user application with Lttng.
I would like to know if it is possible to do it without introducing 
tracepoints in the user code like when the kernel is traced.

For example, I would like to see what every CPU/process is doing in an 
MPI + OpenMP application without putting  tracepoints in it.

Is that possible or is there any alternative to Lttng to generate ctf 
traces?

Thank you very much.
Your help is very much appreciated =)


Beatriz Aguilar

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
