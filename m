From: Thuya Aung <thuyaaung2002@yahoo.com>
Subject: snapshot issue in lttng 2.3.0
Date: Tue, 24 Sep 2013 13:42:44 -0700 (PDT)
Message-ID: <1380055364.86398.YahooMailBasic__35698.44059316$1380055436$gmane$org@web163905.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm41-vm1.bullet.mail.gq1.yahoo.com ([67.195.87.88])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thuyaaung2002@yahoo.com>) id 1VOZRb-0005WY-2W
	for lttng-dev@lists.lttng.org; Tue, 24 Sep 2013 16:42:56 -0400
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

Hello lttng-dev,

With lttng 2.3.0 in Ubuntu 12.04 LTS, I only get the tracepoints in kernel folder with snapshot mode. I do not see anything for userspace tracepoints. 
The following is the way I setup for lttng session

lttng create mySession --snapshot

lttng enable-channel kCh --buffers-global --subbuf-size=1048576 -k
lttng enable-event -a -k 

lttng enable-channel uCh --buffers-uid --subbuf-size=1048576 -u
lttng enable-event -a -u

sleep 1
lttng start mySession
sleep 60

lttng snapshot record


lttng stop mySession
lttng destroy mySession

I got the error message saying "Undefined command" with the following

lttng add-output -n myNewOutput file:///home/taung/output (<--- following the examples of man 1 lttng)

Did I do something wrong? What else I should be doing in order to use snapshot feature?

Thanks in advance,
Thuya Aung
