From: Aaron Spear <aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Java code for CTF trace writing?
Date: Mon, 15 Apr 2013 14:14:07 -0700 (PDT)
Message-ID: <383930718.1659598.1366060447359.JavaMail.root@vmware.com>
References: <1979434593.1654651.1366060059638.JavaMail.root@vmware.com>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1979434593.1654651.1366060059638.JavaMail.root-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>, lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
List-Id: lttng-dev@lists.lttng.org

Hi all, 

I was wondering if anyone knew of some open source Java library that could WRITE CTF traces? I am using the linuxtools/TMF plugins to read CTF traces, but now need to write them from Java as well. 

I have a use case where I have an "event bus" in the Java app world and I would like to persist this event stream as a CTF trace. In this particular use case, the speed/low intrusiveness of LTTng UST is not as important as the portability, so a pure Java solution is ideal, though not strictly required. 

Also, please let me know if there are others out there who are interested in collaborating in writing such a library.

regards, 
Aaron Spear 
