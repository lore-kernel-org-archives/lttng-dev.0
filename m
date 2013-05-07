From: Andre Bette <andreb@stud.fh-dortmund.de>
Subject: Creating a CTF-File
Date: Tue, 07 May 2013 17:13:04 +0200
Message-ID: <51891A00.8040408__32271.3588750505$1367939618$gmane$org@stud.fh-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.fh-dortmund.de ([193.25.16.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <andreb@stud.fh-dortmund.de>) id 1UZjZh-0002lj-Vw
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 11:13:06 -0400
Received: from [192.168.178.2] (dtmd-4d0bf3fa.pool.mediaWays.net
	[77.11.243.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout1.fh-dortmund.de (Postfix) with ESMTPSA id 926C99A89
	for <lttng-dev@lists.lttng.org>; Tue,  7 May 2013 17:12:59 +0200 (CEST)
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

Hi everyone,
I have a question about the concept of the CTF data types implementation.

I want to write the packet header and context.

Example:

BinaryCTFWriter writer = new BinaryCTFWriter("F:/kernel"); // Class from 
the Javeltrace Project


writer.openStream(0);

PacketInfo packet = new PacketInfo(0,?,?) ;     //PacketInfo(int 
steamID,StructDefinition header, StructDefinition context)

writer.openPacket(packet);

...

How do I create the data(Timestamp begin , Timestamp end etc.) for the 
header and context? I dont understand the concept of 
StructDefinition/StructDeclaration. Do I need a metadata file for this ? 
Or can I write it later ?




Best Regards,

Andre
