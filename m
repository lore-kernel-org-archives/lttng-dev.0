Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22426CD98C0
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Oct 2023 21:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696974732;
	bh=TMvXjob/NSZgP8JRf8G1STVggR/CUG/uHLMblfpvOQE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Pr7D87aZGr4uy3ZQZCoLr6Ddn4vSolIyG/OymcknUcpkaB178NCxqCArcORmdPiSu
	 Em+69va3pnMN/l7bSsjeSOJ2782/EuKTPA68kA/oIwZKDs8pVhFw+5Ts0XA2SsQ599
	 eT8HQTu5FwgPA4Mkh1tBExPrnTIG0E6hXZ0EypeC+NyGXPaGhJYbzhGywesiiiCwEf
	 15OpOHD09OUkThDs08bxryHjXR5rk+pdoilWBnps7JXE3Xze9Ilu4CK+GMcPF6pvBb
	 f5Vwhmzzg/GQQNGFAYZ6hlF2Jotaga6kJib5ZOIxEM6uyAy7zlXbfNcKJoAuUBVvHP
	 p9jd3+7EuAGiQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S4qPR1B7Sz2w27;
	Tue, 10 Oct 2023 17:52:11 -0400 (EDT)
Received: from emp-mxpp104.dcs.leidos.com (emp-mxpp104.dcs.leidos.com
 [149.8.243.14])
 by lists.lttng.org (Postfix) with ESMTP id 4S4q0K60cnz2wF7
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2023 17:33:53 -0400 (EDT)
Received: from pps.filterd (emp-mxpp104.dcs.leidos.com [127.0.0.1])
 by emp-mxpp104.dcs.leidos.com (8.17.1.5/8.17.1.5) with ESMTP id 39AKNjeA009782
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2023 16:33:50 -0500
Received: from epsp-dlp-prev22.dcs.leidos.com (EPSP-DLP-PREV22.dcs.leidos.com
 [10.227.23.22])
 by emp-mxpp104.dcs.leidos.com (PPS) with ESMTPS id 3tk1eym88n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2023 16:33:49 -0500
Received: from emp-mxpp112.dcs.leidos.com (unknown [149.8.242.102]) by
 EPSP-DLP-PREV22.dcs.leidos.com with smtp
 (TLS: TLSv1/SSLv3,128bits,ECDHE-RSA-AES128-GCM-SHA256)
 id 0f9f_1102_4b4cec4d_b3f7_440b_af30_3957f07b0fd4;
 Tue, 10 Oct 2023 21:33:49 +0000
Received: from EMP-EXMR1822.corp.leidos.com (EMP-EXMR1822.corp.leidos.com
 [10.128.180.12])
 by emp-mxpp112.dcs.leidos.com (8.17.1.5/8.17.1.5) with ESMTPS id
 39ALXmCY013212
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2023 16:33:49 -0500
Received: from EMP-EXMR1822.corp.leidos.com (10.128.180.12) by
 EMP-EXMR1822.corp.leidos.com (10.128.180.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2507.32; Tue, 10 Oct 2023 16:33:47 -0500
Received: from USG02-BN3-obe.outbound.protection.office365.us (10.226.129.6)
 by EMP-EXMR1822.corp.leidos.com (10.128.180.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 16:33:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Okb03qs7IftncteOiyFeTYkiadb54niqL4xOpCz9ns1ozcHykLQMepOfiif4j8t4vAYJXGzJUzkm/2NK9mUdWWX0G7VRhxeodmeMuQJFaU6qgnuBEbsaEAr6Ps8inUtRXHfuBUUU2w0yUJHPHrYR4d9YPquWAukbSeMVKoLuAN5OyHkeLbVPYNyZcFts4xELHWTKXypWTxUswCM1zi28V3v+tSRb2COvehj5T/3g5cgHYwtvsBBt23C1FcutjmeiE/DlsyD77fgNrAVD/EUu+0loXTOZXJ1OAxJCDQxhWuVRG8avqfuQFk8EhAoxnABr2wMqsCtiQhrWl8fQquD8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5sCun2CLzWZCRoSuP0iIR3FSr8S+IUx+OsGNjumg3M=;
 b=sou+CZA6WVe8QNkSoIOY3ORGEGf/0iW62CyqOEWF82a82ZPDqUXyCLe+fFVE7ZFW5Vp0USgL4C4zzJl0RS5WYNlwt/ltLAG05imuFrhvWR4vOrbL7UT950ks7FsaWwLlNTD8MdvPsrt6thzU0K3jYK4Yi44AkaF3LgKehXDQb96h3EW6Y6aaA2i/104kWUfclSQJ/dJcxizhCYiPUR5EGO2G2V3g4Z8+Dfw7ZI5ZQyC/tRegJA4Vypy80PDJYSEfrTPsa4UAz7VO8i6nrFGj+zCQLpp22fL97V/SxTvgY6M6fKkRza/74HiRo6K1X9xYMU1ex7nu738P6pDZPNKuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leidos.com; dmarc=pass action=none header.from=leidos.com;
 dkim=pass header.d=leidos.com; arc=none
Received: from BN2P110MB1237.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:179::21)
 by BN2P110MB1334.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.34; Tue, 10 Oct
 2023 21:33:46 +0000
Received: from BN2P110MB1237.NAMP110.PROD.OUTLOOK.COM
 ([fe80::b917:ae28:cdad:43bf]) by BN2P110MB1237.NAMP110.PROD.OUTLOOK.COM
 ([fe80::b917:ae28:cdad:43bf%4]) with mapi id 15.20.6813.027; Tue, 10 Oct 2023
 21:33:46 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: BabelTrace 1.5.8 Error
Thread-Index: Adn7wJyhsi9YOw7oQ16Mjddl8KK43g==
Date: Tue, 10 Oct 2023 21:33:46 +0000
Message-ID: <BN2P110MB1237C60889C689B25E536D96DACDA@BN2P110MB1237.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_ActionId=0a630323-b131-425a-99cc-41acb9ecfae7;
 MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_ContentBits=0;
 MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_Enabled=true;
 MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_Method=Privileged;
 MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_Name=Unrestricted;
 MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_SetDate=2023-10-10T21:33:43Z;
 MSIP_Label_c968a81f-7ed4-4faa-9408-9652e001dd96_SiteId=b64da4ac-e800-4cfc-8931-e607f720a1b8;
dlp-product: dlpe-windows
dlp-version: 11.10.901.55
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1237:EE_|BN2P110MB1334:EE_
x-ms-office365-filtering-correlation-id: efe2b9d1-a2b9-4060-386e-08dbc9d8958d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChrAbTQNFL9GNvTF/LhsjCWsqjUMnQ7LjA1kOlkV0Nyzi6tlsgB8Xrs0F3I9oORFRz4kaJw3w6FuhR+pLL9g1wYMCB/HWqIWzkVs51+rgKWu20MlUfxXSldzSbZ8sITxF6AI4UDffXWeczf46blvsw4AXTr97p95zzQ4JX8NStahebz0H7AKMajcGCjtDuuFHGSJ6P3EWXH6oGl/qfqJRc0uCTgqwk8HD2i+DB0EpZBV33pn3J9IJils5Uu2bnoLOmF5+O5KC5jqtYI2nbCyU6u5tHGUochgUPwd868xzLihxWWiTJGLh4gDO784bsf3R2FPFvifHQOFnFzw2E+L/EeHOqH3spAc51ctp+6Vqc4e1cwG1mCv9HFs98v01nopHy+sxvHtpA6vePHkgBEDLZsyAE08FRCZcullfVgBNq9qJecfpvhgCux9qnXWrrP5U/PNpeLMklPpKgvegGftk/IGMnkoTTRupFRXcM//Wz5rpKD0DP5/URb+r0kTwalCrOVdqsnPuxYafKjIsQbn7aPh7VPHeR5pw7MTWOT+FHG+1BXZUSZ+SVY4cgjywmP4YTW2S7EvUhk3AF6GX7EiklUCHW2snNGUsE0n/vNSvgI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN2P110MB1237.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(230922051799003)(186009)(1800799009)(451199024)(498600001)(2906002)(99936003)(6506007)(966005)(83380400001)(66446008)(38070700005)(166002)(33656002)(38100700002)(7116003)(66476007)(26005)(122000001)(76116006)(52536014)(8676002)(5660300002)(86362001)(8936002)(71200400001)(9326002)(55016003)(9686003)(7696005)(6916009)(64756008)(66946007)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: FQMNtdowhU8b4MNxtYQHREYI3pxOoJlg3LXN5yo4zbIKmrdA2DWE9AzbbNxtroTT0eP+Day59tWcOdFeoXH1lYBto/FuUH7zua1KkvlxcJbbcL+B+fVSrIf6+ItBRKLxgo57+6zfmSui1IyFrZ4IFrhw43Sb/H69knxzGGc5lYAiXYbwVkfoVi20R6+5zPyD1B3riysmybrOV95fWRwjNa5BCWsZ2TMg6CcOpi9mcoBdZxwMCrCTtW0v9WXV4o4UyJmjLvgI9qqf5Are214mEXcYTPzBUejcAxsCE68aww6n1iHApNslBlIhJDqer1SsnXz4WO5dtzhdmLR9leM+8Z9bj9M66Ns9VzaDsUdxAlWXhV2LduLNL4FQngzXSSY3U5i95iS/2VTH0n2Upnt48OS3YOWcYR71nSMgv2YvRyw=
Content-Type: multipart/mixed;
 boundary="_004_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1237.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: efe2b9d1-a2b9-4060-386e-08dbc9d8958d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 21:33:46.2193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b64da4ac-e800-4cfc-8931-e607f720a1b8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1334
X-OriginatorOrg: leidos.com
X-EmailSecurity-Header: 1
X-RCIS-Action: ALLOW
X-Proofpoint-ORIG-GUID: k9zyNGhSrETG0yfLMWoinYYq4aQHYax1
X-Proofpoint-GUID: k9zyNGhSrETG0yfLMWoinYYq4aQHYax1
X-Proofpoint-Spam-Details: rule=notspam policy=outbound score=0 adultscore=0
 malwarescore=0
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100167
X-Mailman-Approved-At: Tue, 10 Oct 2023 17:52:09 -0400
Subject: [lttng-dev] BabelTrace 1.5.8 Error
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Smet, Jonathan A. \[US-US\] via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Smet, Jonathan A. \[US-US\]" <Jonathan.A.Smet@leidos.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_004_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_
Content-Type: multipart/alternative;
	boundary="_000_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_"

--_000_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I found this email in the README of https://github.com/efficios/babeltrace/=
tree/stable-1.5

I have a question regarding the usage of BabelTrace using version 1.5.8. I =
am running on Ubuntu 20.04 and have installed or dependencies to use BabelT=
race with Python bindings:

  *   sudo apt-get install lttng-tools
  *   sudo apt-get install lttng-modules-dkms
  *   sudo apt-get install liblttng-ust-dev
  *   sudo apt-get install python3-babeltrace

When trying to import BabelTrace in a Python script with "import babeltrace=
", I receive the following error (more error output in the attached text fi=
le): "ModuleNotFoundError: No module named 'babeltrace._babeltrace'" follow=
ed by "ModuleNotFoundError: No module named '_babeltrace'".

My folder structure at /usr/lib/python3/dist-packages/babeltrace are as fol=
lows:

  *   _babeltrace.cpython-38-x86_64-linux-gnu.so
  *   Babeltrace.py
  *   __init__.py
  *   /__pycache__

I've been trying to debug this issue for a couple of days, but am running i=
nto a wall. I've decided to email your team in case you have seen this issu=
e before, or are able to spot a simple issue with my setup.

Thank you,
Jon Smet




--_000_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:449589223;
	mso-list-type:hybrid;
	mso-list-template-ids:-215030838 67698689 67698691 67698693 67698689 67698=
691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1112475498;
	mso-list-type:hybrid;
	mso-list-template-ids:1606161172 67698689 67698691 67698693 67698689 67698=
691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I found this email in the README of <a href=3D"https=
://github.com/efficios/babeltrace/tree/stable-1.5">
https://github.com/efficios/babeltrace/tree/stable-1.5</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a question regarding the usage of BabelTrace =
using version 1.5.8. I am running on Ubuntu 20.04 and have installed or dep=
endencies to use BabelTrace with Python bindings:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">sudo apt-get install lttng-tools
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">sudo apt-get install lttng-modules-dkms<o:p></o:p></l=
i><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level=
1 lfo1">sudo apt-get install liblttng-ust-dev
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">sudo apt-get install python3-babeltrace<o:p></o:p></l=
i></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When trying to import BabelTrace in a Python script =
with &#8220;import babeltrace&#8221;, I receive the following error (more e=
rror output in the attached text file): &#8220;ModuleNotFoundError: No modu=
le named 'babeltrace._babeltrace'&#8221; followed by &#8220;ModuleNotFoundE=
rror:
 No module named '_babeltrace'&#8221;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My folder structure at /usr/lib/python3/dist-package=
s/babeltrace are as follows:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2">_babeltrace.cpython-38-x86_64-linux-gnu.so<o:p></o:p></li><li class=
=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 lfo2">Bab=
eltrace.py<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-le=
ft:0in;mso-list:l1 level1 lfo2">__init__.py<o:p></o:p></li><li class=3D"Mso=
ListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 lfo2">/__pycache=
__<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve been trying to debug this issue for a cou=
ple of days, but am running into a wall. I&#8217;ve decided to email your t=
eam in case you have seen this issue before, or are able to spot a simple i=
ssue with my setup.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">Jon Smet<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_--

--_004_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_
Content-Type: text/plain; name="babeltrace_error.txt"
Content-Description: babeltrace_error.txt
Content-Disposition: attachment; filename="babeltrace_error.txt"; size=2195;
	creation-date="Tue, 10 Oct 2023 21:30:13 GMT";
	modification-date="Tue, 10 Oct 2023 21:33:45 GMT"
Content-Transfer-Encoding: base64

LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpNb2R1bGVOb3RGb3VuZEVycm9yICAgICAgICAgICAgICAgICAg
ICAgICBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCkNCi91c3IvbGliL3B5dGhvbjMv
ZGlzdC1wYWNrYWdlcy9iYWJlbHRyYWNlL2JhYmVsdHJhY2UucHkgaW4gc3dpZ19pbXBvcnRfaGVs
cGVyKCkNCiAgICAgMjUgICAgICAgICB0cnk6DQotLS0+IDI2ICAgICAgICAgICAgIHJldHVybiBp
bXBvcnRsaWIuaW1wb3J0X21vZHVsZShtbmFtZSkNCiAgICAgMjcgICAgICAgICBleGNlcHQgSW1w
b3J0RXJyb3I6DQoNCi91c3IvbGliL3B5dGhvbjMuNy9pbXBvcnRsaWIvX19pbml0X18ucHkgaW4g
aW1wb3J0X21vZHVsZShuYW1lLCBwYWNrYWdlKQ0KICAgIDEyNiAgICAgICAgICAgICBsZXZlbCAr
PSAxDQotLT4gMTI3ICAgICByZXR1cm4gX2Jvb3RzdHJhcC5fZ2NkX2ltcG9ydChuYW1lW2xldmVs
Ol0sIHBhY2thZ2UsIGxldmVsKQ0KICAgIDEyOCANCg0KL3Vzci9saWIvcHl0aG9uMy43L2ltcG9y
dGxpYi9fYm9vdHN0cmFwLnB5IGluIF9nY2RfaW1wb3J0KG5hbWUsIHBhY2thZ2UsIGxldmVsKQ0K
DQovdXNyL2xpYi9weXRob24zLjcvaW1wb3J0bGliL19ib290c3RyYXAucHkgaW4gX2ZpbmRfYW5k
X2xvYWQobmFtZSwgaW1wb3J0XykNCg0KL3Vzci9saWIvcHl0aG9uMy43L2ltcG9ydGxpYi9fYm9v
dHN0cmFwLnB5IGluIF9maW5kX2FuZF9sb2FkX3VubG9ja2VkKG5hbWUsIGltcG9ydF8pDQoNCk1v
ZHVsZU5vdEZvdW5kRXJyb3I6IE5vIG1vZHVsZSBuYW1lZCAnYmFiZWx0cmFjZS5fYmFiZWx0cmFj
ZScNCg0KRHVyaW5nIGhhbmRsaW5nIG9mIHRoZSBhYm92ZSBleGNlcHRpb24sIGFub3RoZXIgZXhj
ZXB0aW9uIG9jY3VycmVkOg0KDQpNb2R1bGVOb3RGb3VuZEVycm9yICAgICAgICAgICAgICAgICAg
ICAgICBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCkNCi90bXAvaXB5a2VybmVsXzg3
NjczLzIyOTU0NDY1MjEucHkgaW4gPG1vZHVsZT4NCi0tLS0+IDEgaW1wb3J0IGJhYmVsdHJhY2UN
Cg0KL3Vzci9saWIvcHl0aG9uMy9kaXN0LXBhY2thZ2VzL2JhYmVsdHJhY2UvX19pbml0X18ucHkg
aW4gPG1vZHVsZT4NCiAgICAgMjEgIyBUSEUgU09GVFdBUkUuDQogICAgIDIyIA0KLS0tPiAyMyBm
cm9tIC5iYWJlbHRyYWNlIGltcG9ydCAqDQogICAgIDI0IA0KICAgICAyNSBfX3ZlcnNpb25fXyA9
ICcxLjUuOCcNCg0KL3Vzci9saWIvcHl0aG9uMy9kaXN0LXBhY2thZ2VzL2JhYmVsdHJhY2UvYmFi
ZWx0cmFjZS5weSBpbiA8bW9kdWxlPg0KICAgICAyNyAgICAgICAgIGV4Y2VwdCBJbXBvcnRFcnJv
cjoNCiAgICAgMjggICAgICAgICAgICAgcmV0dXJuIGltcG9ydGxpYi5pbXBvcnRfbW9kdWxlKCdf
YmFiZWx0cmFjZScpDQotLS0+IDI5ICAgICBfYmFiZWx0cmFjZSA9IHN3aWdfaW1wb3J0X2hlbHBl
cigpDQogICAgIDMwICAgICBkZWwgc3dpZ19pbXBvcnRfaGVscGVyDQogICAgIDMxIGVsaWYgX3N3
aWdfcHl0aG9uX3ZlcnNpb25faW5mbyA+PSAoMiwgNiwgMCk6DQoNCi91c3IvbGliL3B5dGhvbjMv
ZGlzdC1wYWNrYWdlcy9iYWJlbHRyYWNlL2JhYmVsdHJhY2UucHkgaW4gc3dpZ19pbXBvcnRfaGVs
cGVyKCkNCiAgICAgMjYgICAgICAgICAgICAgcmV0dXJuIGltcG9ydGxpYi5pbXBvcnRfbW9kdWxl
KG1uYW1lKQ0KICAgICAyNyAgICAgICAgIGV4Y2VwdCBJbXBvcnRFcnJvcjoNCi0tLT4gMjggICAg
ICAgICAgICAgcmV0dXJuIGltcG9ydGxpYi5pbXBvcnRfbW9kdWxlKCdfYmFiZWx0cmFjZScpDQog
ICAgIDI5ICAgICBfYmFiZWx0cmFjZSA9IHN3aWdfaW1wb3J0X2hlbHBlcigpDQogICAgIDMwICAg
ICBkZWwgc3dpZ19pbXBvcnRfaGVscGVyDQoNCi91c3IvbGliL3B5dGhvbjMuNy9pbXBvcnRsaWIv
X19pbml0X18ucHkgaW4gaW1wb3J0X21vZHVsZShuYW1lLCBwYWNrYWdlKQ0KICAgIDEyNSAgICAg
ICAgICAgICAgICAgYnJlYWsNCiAgICAxMjYgICAgICAgICAgICAgbGV2ZWwgKz0gMQ0KLS0+IDEy
NyAgICAgcmV0dXJuIF9ib290c3RyYXAuX2djZF9pbXBvcnQobmFtZVtsZXZlbDpdLCBwYWNrYWdl
LCBsZXZlbCkNCiAgICAxMjggDQogICAgMTI5IA0KDQpNb2R1bGVOb3RGb3VuZEVycm9yOiBObyBt
b2R1bGUgbmFtZWQgJ19iYWJlbHRyYWNlJw0KDQo=

--_004_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_004_BN2P110MB1237C60889C689B25E536D96DACDABN2P110MB1237NAMP_--
