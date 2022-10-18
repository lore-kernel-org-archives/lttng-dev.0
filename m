Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125EDC4332F
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Oct 2022 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666106524;
	bh=6kAC4ZjwiOaj0TPen6tAZw3FvaBV9joADSXcr6/RMEQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=cGxFdJwbT3xyUIViVfnoopTUvLBs2D8MObHqoOo7dfwQFa+Vkn/+7lEAivZWLaP6x
	 MJD1nDLnZ1J+fG9wjCfQ8sq48t9Y/iNFcdQIWy/KZjD+0q2vI/2Pa2ipPFn3Mt/LUT
	 l78q6HGFNEL6oOO1fQqykZldkPHjDW7FD9utM89HCQH3o8PBmPA3CnfDte65CSjj42
	 nyqUAcSWSzQ8p2X+CmnCfFVhgAzQ8DX/RBJk6MqRe3K/O+C+cyR7Qh7HHWD/Rc8mbe
	 Xm7LVDhfrOw3F14jDfNFbYVUzJXY1EZh/OCBuNuJCNi62VxdKT0JnPhzQ1PUa1H7qi
	 JzY4CbWpwu3cA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MsHf40v7Nz8tn;
	Tue, 18 Oct 2022 11:22:04 -0400 (EDT)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by lists.lttng.org (Postfix) with ESMTP id 4MsDWC6YvQz8jG
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 09:00:55 -0400 (EDT)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I9Lduq007350
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 09:00:51 -0400
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3k7rpxk2a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 09:00:51 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ICwtwK021517
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 09:00:50 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3k9ppqdtj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 09:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqIwXqcX/6D1xsdQAtYtl4CxMKKD1OPQzHepAkma5TePiyc96t5TsFHHQP/h6BPHEs8wBcuIWlbVsdqZHwp1dV8liWhaoBfWNvPibV2Yu71V7TBzdMqLnwCDIft3SESCy+xS/sN7P2KnFxsofIFCSDeRhv05QDzrQ5n15iHCaINOawjpV7QjgJ4BFkY0dgJMduwGyIhguxc83+zTFvr2ehcAvVvNcaq02A7eKA8cHHCxmucm/k3XzNo6e0ZzXQNBU+k2xM90lKO7TRzgnvyVlwMBx+jp3RqLRbz8r5pLB8qUNMZCsbxmhRJmsHywEveg4m+gG9FyTZbk3nS1RRzBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr1GwRUXTI/SDJh2Cbc7vDGFGLbg7HQ7EzPVR4PmAY8=;
 b=TolSve2qJwzj6v/tq4fBru3oRFQVX77o9UjsiUDq+bb1NGPtStvgwijMXWuZS/n9jdwFYxntN85419vSCbvdz8wcW7qw05fG6h4onXqsjHAKsCOmWrxOkPbYQiGwmc6DxBjYUCR/8iBGl2RFGdUOdNMfgB+ibKdU86KcB5mEiixNTCvwywUxzQs8MDOpo0VIegZBvjmY06NHNMc8VbcQTg2pqB6SbQ9OWnN3qLnpyt0x5lnq4pPYPxKY/ZP2XB3n3BsoskRIuhPgdITIFeMEOs5ciqIYEK/OpzcxK7ceKYWaH5wLUw3a2B46/moBwSfVZ/32RXjfzadDsYPM6m0U/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB6375.namprd19.prod.outlook.com (2603:10b6:8:95::20) by
 DM4PR19MB5713.namprd19.prod.outlook.com (2603:10b6:8:5c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 18 Oct 2022 13:00:47 +0000
Received: from DS7PR19MB6375.namprd19.prod.outlook.com
 ([fe80::14b9:ed78:c1bd:11ba]) by DS7PR19MB6375.namprd19.prod.outlook.com
 ([fe80::14b9:ed78:c1bd:11ba%4]) with mapi id 15.20.5723.029; Tue, 18 Oct 2022
 13:00:47 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Shared memory circular buffer and K8s pods
Thread-Index: Adji8M7GViVJNUMsRCq/vvRKs+l3Xg==
Date: Tue, 18 Oct 2022 13:00:47 +0000
Message-ID: <DS7PR19MB637575A3329444AD675C12379F289@DS7PR19MB6375.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-10-18T13:00:46Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=815e7966-89e7-49b5-be45-b0a3cb082750;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB6375:EE_|DM4PR19MB5713:EE_
x-ms-office365-filtering-correlation-id: 46dde4fd-0bc4-4f05-c777-08dab108c6b2
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mn82Q6WVx/G5Rm8gpCsnN4TAY6T7CPS93fpMV3Xgq1HHkuueT9RjJryUKiZnrpRReiEs0PzkBkLfd8wEQbiP+SFlLR6phzkB/QAg7cQEXOGsdE8xy3BkFsvJ3BD5SE5S/xasEpXka7cwKK8Em0+qRHeHOMqvwOCQMMvund8VOsBEbBq+IQqa9LawFqKTPalWGjpmV4z/AaAtyXvVX06p6ckJgdcsJ+dnDyJPLf+fs5AVGSuaJnFhIoQhB9UidytB/lQiikQWYwWtylMPBcuAyUXU2bg76XztXocnuwdw3Qa4/6Ms6rRrmLO4TPc+TO5FJ1SCPYxOHCbFAkfFG8gvrFe43ObhfTubn9rMVp/hb+OCEeoxHS3L6M6Rk3QNtcZBlvApf77UBV7zq/AVmIJM53jvy52LKWE/fRWgE2zG7x0kKVBVOp2G6KT5WE3egnoQEteZ25wNx5BT3KspC6O9Zc6QARM3Pq1cebU3eDutVwqZPd1cLcLNaBV+AA1S/ffuOewqP+GSCqgdzgwQQGu8SsQacR3DxW5Q0MfHfKq17F+c6NLpnYUVK3ZbhLbChZbvD/1tfb2MIq95YXwHpymnLuaB7lW2Z67nMZNARaaH9/5JwiHk8edZZdp3kJmqRZSVvdKlnK773mMrrW//kzT4VdHFPouAc/7R97asU4MD/vc5wjY4e9HRUWwC/LgpF7p9K31VJa39b1mZIpxdLr4HVRVMw1uMUi49QZiZ9yPDzAxzZdCiOrUisXPnsI09+VdgtmfkXVYOreRVZpNMb2gIzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR19MB6375.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(84040400005)(451199015)(7696005)(6506007)(478600001)(9686003)(26005)(186003)(33656002)(71200400001)(2906002)(83380400001)(55016003)(86362001)(6916009)(786003)(316002)(122000001)(4744005)(52536014)(9326002)(5660300002)(38100700002)(82960400001)(8936002)(76116006)(66946007)(8676002)(38070700005)(66556008)(66476007)(66446008)(64756008)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hQKu9GM7zbqwxXWhiYLC7HKY89CsDELobSYtrYUc04CMO2WF5BzmTjnePGkB?=
 =?us-ascii?Q?vFuJIIp1Ezx8x77YKTGjxO1OwWqargZGCFmSbGOQSI4WRA74xxtYsW7qbb8o?=
 =?us-ascii?Q?lm5t/lZ8l9D5vV4YLssDGNRIT+uuk4s5Xr468iavdp/Q1ck6wQGVoBgNyx0+?=
 =?us-ascii?Q?Uaf/LDFTla4dh2Eyhv8e615YoDsPdUD3IIF/Ob3RKprwIhpWP8tKEQN6AA36?=
 =?us-ascii?Q?RTzvhAQOdzbiC7dFyrfEWNbcohUEr3MGBuLrQjxXgyFMUgS4QpQyerzLytj1?=
 =?us-ascii?Q?dRpkNSxncQYKPDDgxyuV4Iau2DD//Ahnh6aLy/zwDroeWbo5vd/u7ovzmWZz?=
 =?us-ascii?Q?MlCi1ybTZFxroUKbbLKQB82J22GyNzorOhPBauoazuC1OPj9vS60O6NTgWzl?=
 =?us-ascii?Q?bvT0rhPxxRUuf7Z5lTYEGjMaIga1sT5iM9JUZSFNM5A4qNxPTvXaeldYQdDg?=
 =?us-ascii?Q?4/w4RTVlaERDrfd31bJZJnWMNWo2LzyTrZyGPW/mtK9JsoRxE7OE3aSaPr5Z?=
 =?us-ascii?Q?N8/GjBxP0vvhAfQs5eEdoPfYrgQAhcHP0w0HZ7V4fjfPz7HTmfKcNyDkk09E?=
 =?us-ascii?Q?R5KM9e5B+HQkhPhcpnt6xVwpCTvP8+yaYWXW7yWTZvVaTl8vLQEq+bwxBR5c?=
 =?us-ascii?Q?6vHfuN+cZFHHRML6Z1ec/h04fTQiGApec5bz7Jnn7jME2ZV1TvmCXby/Fhug?=
 =?us-ascii?Q?fqcyLUpZ9/T/dLU+PkIg0PBeHgNBK4NQih64CDWsLCEF3RqdKYxknPrPRwsK?=
 =?us-ascii?Q?NR1cmeI0i/VRyGIDWs2AOJzbuiBr+DXQ8wkHbAw/YJ8dTQIgMimMTG8lYbCM?=
 =?us-ascii?Q?cs91ADYhb6nEtSVvzR9huSo7dichPja1f7kRMu/R+XM+Ss52BQ2pk9Ynhsjx?=
 =?us-ascii?Q?TOxRZgsDsuSeCG1PDa+nL7okDZR+p1xuq3+mXMt/TE/HHO2iiEt92GpUgMHw?=
 =?us-ascii?Q?M5P9QSflYZwaZCV378MgA/O5x8k36rRcrKbAS3nnXdqs3HVBRGyXGaGXodJB?=
 =?us-ascii?Q?g26L/9b1YpN+7DcmJJvlK9Hvh6wUez5Ljw9GYWnIFn7ttrmuj8wPaUdeRhOW?=
 =?us-ascii?Q?5kG22J9KAcQ0gNdkZ0g3yVGVwtwBfFCMLu10dhDKunZK0TpP0pX1U0GH91qq?=
 =?us-ascii?Q?mq/HywYlgdYKgirz4J6JSa9aSNqBVRZdITeWCap/3gyqUxntkbpT6QmFcaWa?=
 =?us-ascii?Q?osVbql2mNQKTor8uBejsI2AvE1SLNY7I7/ujw0gIh5f/izbq2Jw88H77q8pv?=
 =?us-ascii?Q?W/8/b+zvQ6/qJDIfSs0zxFuWbRDZKNC+PCfjIl5utR+JnjTjO8JNBjQS8UMo?=
 =?us-ascii?Q?eQH2oK2xGxnk1ziVjO/a5WH9/5hcTaTW//0Ofxettqvw11XsXOQ4fAtyIbWx?=
 =?us-ascii?Q?dSEnVHvwezTnwtWemsBImoNUTqlx5RuquBMd7n1iJGaZjjjphsse67HXLO1Z?=
 =?us-ascii?Q?GMLcBjFR0QcAduyeGDd4+IFie9v1qY6zv2MLxNPVNMgdimnxkdoMtbLIaiEk?=
 =?us-ascii?Q?NfLXjWXh8h9yySIY7XTWp7R6rpDE1UomsW7XX+xna9qxqjcYPjp4MDI9Gq4D?=
 =?us-ascii?Q?Uc3CTJPxpg+2+7mjqWQl3wYJAmE+htVb42uITj3O?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6375.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dde4fd-0bc4-4f05-c777-08dab108c6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:00:47.7494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7hB0bHB1xTaRgVt/SfPFoQ/u9BBLkmKq5bnJ7a5tXAXiqgLj41/WvMvjoqw9FLGc+t7E4bY6ZOLCmCiEpiLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=502
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180074
X-Proofpoint-GUID: v0piR0XYbxK6SGAUITdM9xCTNUqqGTmz
X-Proofpoint-ORIG-GUID: v0piR0XYbxK6SGAUITdM9xCTNUqqGTmz
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=614 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180075
X-Mailman-Approved-At: Tue, 18 Oct 2022 11:22:02 -0400
Subject: [lttng-dev] Shared memory circular buffer and K8s pods
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
From: "Lemay, Paul via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Lemay, Paul" <P.Lemay@Dell.com>
Content-Type: multipart/mixed; boundary="===============6097187330430995841=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6097187330430995841==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DS7PR19MB637575A3329444AD675C12379F289DS7PR19MB6375namp_"

--_000_DS7PR19MB637575A3329444AD675C12379F289DS7PR19MB6375namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello There,

We are looking at LTTng for a development here at Dell. As I understand the=
 LTTng, there are shared memories of circular buffer traces created between=
  an application and the consumer daemon. After looking at some presentatio=
n that you did, I see that you have started working on containerization and=
 pods.

So our applications run in pods, and am not sure how to organize the pods k=
nowing about those shared memories? Can you help us better understand how o=
ur code should be organized in the context of Kubernetes? Any documentation=
 that we can access?

Best Regards


Internal Use - Confidential

--_000_DS7PR19MB637575A3329444AD675C12379F289DS7PR19MB6375namp_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">Hello There,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are looking at LTTng for a development here at De=
ll. As I understand the LTTng, there are shared memories of circular buffer=
 traces created between &nbsp;an application and the consumer daemon. After=
 looking at some presentation that you
 did, I see that you have started working on containerization and pods. <o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So our applications run in pods, and am not sure how=
 to organize the pods knowing about those shared memories? Can you help us =
better understand how our code should be organized in the context of Kubern=
etes? Any documentation that we can
 access?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<br>
<p class=3D"msipfooter90245289" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:7.0pt;font-family:Calibri;color:#737373">Internal Use - Con=
fidential</span></p>
</div>
</body>
</html>

--_000_DS7PR19MB637575A3329444AD675C12379F289DS7PR19MB6375namp_--

--===============6097187330430995841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6097187330430995841==--
