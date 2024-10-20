import os
import xml.etree.cElementTree as ET
from pathlib import Path
import email


class Einstellung:

    def __init__(self):
        self.__lines = []
        self.__root: ET.Element
        self.__dict: dict = {}
        self.__path = ""

    def __read_file(self, filename: str):
        with open(filename, 'r') as f:
            text = f.readlines()
        for s in text:
            s = s.replace('\n', '')
            s = s.replace('<br>', '')
            if s != '':
                self.__lines.append(s)

                if  s.find(':') != -1:
                    sp = s.split(':')
                    if len(sp) == 2:
                        self.__dict[sp[0].strip()] = sp[1].strip()

    def __add_attrib(self, attrib: ET.Element, field_name: str, key: str):
        field = ET.SubElement(attrib, 'Field')
        field.set('field', field_name)
        val = ET.SubElement(field, 'Value').text = key

    def __add_row(self, values: ET.Element, field_name: str, key: str):
        field = ET.SubElement(values, 'Field')
        field.set('field', field_name)
        val = ET.SubElement(field, 'Value').text = self.__dict[key]

    def __create_xml(self):
        self.__root = ET.Element("List")

        attribs = ET.SubElement(self.__root, 'Attributes')
        self.__add_attrib(attribs, 'Gremium', 'PSA')
        self.__add_attrib(attribs, 'Template', 'Einstellung')
        self.__add_attrib(attribs, 'taskclid', '{AD01FD4F-2AE4-44A2-815C-F6191C2B1120}')

        email_file = open( os.path.join(self.__path, 'mail.eml'))
        email_message = email.message_from_file(email_file)
        self.__add_attrib(attribs, 'Titel', email_message.get('Subject'))
        self.__add_attrib(attribs, 'Antragsteller', email_message.get('From'))

        # Formulardaten
        values = ET.SubElement(self.__root, 'Values')
        self.__add_row(values, 'MA_NAME', 'Name')
        self.__add_row(values, 'MA_VORNAME', 'Vorname')
        self.__add_row(values, 'EINSTELLUNGS_DATUM', 'Datum')
        self.__add_row(values, 'EG_EINSTELLUNG', 'Lohngruppe')
        self.__add_row(values, 'ABTEILUNG', 'Abteilung')
        self.__add_row(values, 'AUSSCHREIBUNGSNUMMER', 'Ausschreibung')
        self.__add_row(values, 'AUFGABENBESCHREIBUNG', 'Anmerkungen')

    def run(self, path: str):
        self.__path = path
        self.__read_file(os.path.join(path, 'index.html'))
        self.__create_xml()

    def print(self):
        ET.indent(self.__root)
        s = ET.tostring(self.__root, encoding='unicode')
        print(s)

    def save(self, path: str):
        Path(path).mkdir(parents=True, exist_ok=True)

        ET.indent(self.__root)
        tree = ET.ElementTree(self.__root)
        tree.write(os.path.join(path, 'data.xml'), encoding='unicode')


def main():
    ein = Einstellung()
    ein.run('C:\\Users\\steph\\Desktop\\Neuer Ordner (2)\\Einstellung')
    ein.save('C:\\Users\\steph\\Desktop\\Neuer Ordner (2)\\Einstellung\\import')


if __name__=="__main__":
    main()
